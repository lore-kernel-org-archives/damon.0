Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2137F8DF;
	Wed,  4 Mar 2026 04:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599289; cv=none; b=t5cChGZLZrdqGVN7DEN9SlZA0tPOfr1fP75ndx1ZtMXrpcP9Ux6GQud8xdAh7wq42iwM8Nq4g+Mrg98q2jjj3N253MiUxMJCXrUcct+GKg1+BJb0X2TKDZTmttDIfIEqfrCjCOUFCNepeZ6Jn131m5+wFq9WCvE4Jq0qvi2MnoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599289; c=relaxed/simple;
	bh=X4gj60NUP5Gx9WKLfYMZxZSkKyfsCySS7inf5fgIm6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HghPooBnMtiwUE4jQ0AAtxvKMbuosWEEtzc4CaSlwrXBqtMLA2cvJQQJhRHPR6ShA7GjpSHmYk7g3wLEmLObSVWV4ONxoL8jwAZ4E4yXMfw7Rx9cYOwVxZdvGKjqNt3GUP2auIE1nrItczLh1mxLQV82W4n1V16mEk7ao3hybow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbFpVsFl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbFpVsFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C5FC2BC9E;
	Wed,  4 Mar 2026 04:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772599289;
	bh=X4gj60NUP5Gx9WKLfYMZxZSkKyfsCySS7inf5fgIm6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbFpVsFlnQBOtv+KJazEbh0Cy0dQ0f6CkZ9Z4jYoAEgvMP5BuHO77eD2CSvnppaH6
	 hv5QGfbB/P1y/D2dZM7sH0Zx+Gp13w2oAimfgHw57a3RQIzacYm6SYOhiinjni88D3
	 oTG9iK90CaX2wJWK3QL1ELhTKa8oR0t7DqB6BR9dxB+nabx5MoZyqq0WwIasgprgdt
	 /LFnEguaqIVjbjxJAqiHgZ+p3LqUhekNa/gAp8kkkOiSP1JPLP+BVTOsmS3j2QXM42
	 KCvhd/V2N7qXB+tqoxyqUyDx1P6zZ1hVr8Gveq/3Xxh7osOJ9WmdF4aJCs5WpXE/ye
	 C+L04GDYmD14g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 07/10] Docs/ABI/damon: update for goal_tuner
Date: Tue,  3 Mar 2026 20:41:16 -0800
Message-ID: <20260304044122.79394-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304044122.79394-1-sj@kernel.org>
References: <20260304044122.79394-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the ABI document for the newly added goal_tuner sysfs file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index f2af2ddedd323..2424237ebb105 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -316,6 +316,12 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the path
 		parameter of the goal.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goal_tuner
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		goal-based effective quota auto-tuning algorithm to use.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/sz_permil
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
