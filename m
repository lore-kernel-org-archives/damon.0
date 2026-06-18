Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D53FFADA;
	Thu, 18 Jun 2026 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795741; cv=none; b=eku6QSRUB+oqVFHVb5kU0ptb1JsapqbOHTgEGRXlPcQoGhkMoMU4OiyRI0liSyJk7XaIHshuywBxzxVmeY6uHroC/oAAM1rk91WtRBf1P7/yTfVRTshv1wtkn6v+mSTDFXybQK5OFxmV/sYYL1DJkRuXBg/+TtgndhPvniv/8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795741; c=relaxed/simple;
	bh=fi6lX815EX7DIpgNSFa0vkD5QF5JHxdgwNGUAa+4bIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTSlkZSaqUmXifjAvMWCCy3LHXonuc6dsicc/vb2dsz4qM+loLHdlvSwDiTcZpXT1TS4JkETi66KcamiraeCN4gvQR9xCMuJIQYPuDzeblAdWy4Zz2r2VpKBtO5/6ETH5NW9xtesFCBmRC5hA+lFGnxtRIc2yCh7PzG6DuMK9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtBlK5Ul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtBlK5Ul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6721E1F00A3D;
	Thu, 18 Jun 2026 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795740;
	bh=V69jCi4XbNmje4yP60Dxbb/L0C+xnieK6ht4H1cDOOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BtBlK5UlYM+SlpNN867/Monyhyen594lyXZabNRLbD4qIcEjkrmiDY9mj3P6IR8mi
	 Merybil4YFBr0m5oyTSItZ+DvBQj+nT5zlmbh+UdQd4o524niI44FZNG4gpfGV2m0u
	 zi4Lu8ScLC1Um1ir/ntVYPNcINLUNx9Z0lSQXLrWCvyCQxRwYNXKJahTvIG5YOU46z
	 tZm11K7AIxfWIqY2hWxHFsra/7aLoqWW9VYY7j5FA42Vys1vEZPtu8jWlveDC1+jNE
	 9SUPtPWpNuebO4M18SUcuBoXT2XTt8a3LQxu4LptORW4s6qNsAi30WdW9LMZXjWiio
	 w1MmmArWERyfA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 10/11] mm/damon/sysfs: kobject_del() probe dirs in probes_addd_dir error path
Date: Thu, 18 Jun 2026 08:15:14 -0700
Message-ID: <20260618151517.5366-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618151517.5366-1-sj@kernel.org>
References: <20260618151517.5366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts.
Fix the issue for data attribute probe filter directories in the error
handling path of damon_sysfs_probes_add_dirs() by adding a kobject_del()
call.

Fixes: af7cb41af9a9 ("mm/damon/sysfs: implement filters directory")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 36a0e82601697..ffbc99411f53b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1183,6 +1183,7 @@ static int damon_sysfs_probes_add_dirs(
 
 		err = damon_sysfs_probe_add_dirs(probe);
 		if (err) {
+			kobject_del(&probe->kobj);
 			kobject_put(&probe->kobj);
 			damon_sysfs_probes_rm_dirs(probes);
 			return err;
-- 
2.47.3
