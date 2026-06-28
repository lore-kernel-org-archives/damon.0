Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ECD3BD642;
	Sun, 28 Jun 2026 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684091; cv=none; b=XMAjllOdeb42U5YtlRqw7LU+gtP5z7kPlcDN4PG5SGnhHqdgiKF9du+qtYBybfgMw8bNv9gg1cBjkO9T9LVNYgF6LCNQkFFnxWcnMXOu38hrqL4dwV6xgvl92p+iLRRgaIF0PPJU/euXQlPm4mJlfEnIaPWM8K0BESHfIyNdXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684091; c=relaxed/simple;
	bh=DCBGJHHVBStVM3CXFaty4twV37tUzCqqJa+5vDC8Qvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaxjOaHvREUVl79RmJFut162KQn1yNbdt2t3UUVImu3Ij7PkPXfrtoYJsbduAAlq5InMNgEss5GA5F1W/5+WWCAUOPrqB+rjxzq3es9ySfTIdz6XaqcjAzgQXKNb8dRXARcOBZ3wthGruSnRuGN1pKYgFKAGGa9ogWzlwYsCYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbVX7xpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbVX7xpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD52E1F00AC4;
	Sun, 28 Jun 2026 22:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782684090;
	bh=fmB3b/npGhBxKB1bt9s9o0NNa/GR5StMFfZ94pT6qAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gbVX7xpreBe4ktCRslGI5Q7jXTCI6P5LRMQMd9ZH4UwEOT/xc3BiULbsxpSOd9r0p
	 L1454zI16P8NGzMpQffPRBmDzPHOUOsD3yMMXv/Axmy9b9cMwnBdH+ZeL1YJNQTp4r
	 HVK02QQzYuqE6uwnp1lhuME215o0xjAw7QIzPXCDqzqTQv4WBV/j4C88JnmsMnoLWk
	 zPw9YFzPHs6r5ioRRCt2E4ltdZAAkb4uUlXF4oY0C4eEzvlCMRpiolECOtskyKJOcP
	 yqciI8+R9JDzogO9xlxPm+/HN9MRto91y7ns2F668SrfcCPzVOqlDGEScoruIDh7ft
	 oRSiKlbyaXPaw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/11] mm/damon/sysfs: kobject_del() probe dirs in probes_addd_dir error path
Date: Sun, 28 Jun 2026 15:01:19 -0700
Message-ID: <20260628220121.97360-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628220121.97360-1-sj@kernel.org>
References: <20260628220121.97360-1-sj@kernel.org>
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
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0ccdc71275d52..e3526a263e205 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1181,6 +1181,7 @@ static int damon_sysfs_probes_add_dirs(
 
 		err = damon_sysfs_probe_add_dirs(probe);
 		if (err) {
+			kobject_del(&probe->kobj);
 			kobject_put(&probe->kobj);
 			damon_sysfs_probes_rm_dirs(probes);
 			return err;
-- 
2.47.3
