Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47F3368A3;
	Mon, 27 Apr 2026 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302763; cv=none; b=rM6wkt8q32zo25JaeWJwhKiDhxY2BaXvceeuLRStg5ggLwpHKdJcPFk7DSei8It6nuUrwRDRDNtc88IOkoKYXmzQ1byktpcHaaCQhFc9Xp2kMc2zjemjddO3IuXO8kdh0KHjwaF8NyC0/0/lDeJfa+htJItYBY2JesRDufkVuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302763; c=relaxed/simple;
	bh=TJXeffpmshBn5e3s77gk9ewA/YmV5afqYkZ0L4RsmNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaBszkZJwPmGKJiAZrRptFAobEL0r/WBIiM1wQOgfGiOJuVWVX0O5m55wooNYqqobkBYfg5N4AtWk5lwNs0TeKBFCbqAwW/AsjKpZbb5DHlL8H8rheLbwzRGdMBlb1ZvNn7BuSUwotkRQkzdDPeSsqldze7GOgadmlLeJ6Bk/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIxHwC7j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIxHwC7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1F2C19425;
	Mon, 27 Apr 2026 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302763;
	bh=TJXeffpmshBn5e3s77gk9ewA/YmV5afqYkZ0L4RsmNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIxHwC7jpSTJLYHo4UAK3o1BQt0TxmjOyiTaW/8vKTIqO1Fi36gO4inEtqu7OvaYL
	 ea5lnGOmDsGrFslRP0dMXV6FS1c1TSBJEPDDYJ1fvVlFB8hEYiZhE/W0o+38XaNpNp
	 AWv+FPlqmqABpRiVtWo/UYn4na6zdhN4vAhUZMi7xmslSJCpilxtXYvteLPqpoB7LW
	 DtRukm/NtPKKGOueXTUC+nDuEjwiPKrU1MOnubP19Zrrfwczwuc/1L4NhDbv9FZ0o/
	 HMH7+YqNp6fOIiHpP2q1NRZAYnTDK0SciY5aOW5MpRkwrgQqE1B+0rDukd5x776b/Q
	 D0bXUjxFLJRjA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 07/10] selftests/damon/_damon_sysfs: support pause file staging
Date: Mon, 27 Apr 2026 08:12:26 -0700
Message-ID: <20260427151231.113429-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427151231.113429-1-sj@kernel.org>
References: <20260427151231.113429-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON test-purpose sysfs interface control Python module, _damon_sysfs,
is not supporting the newly added pause file.  Add the support of the
file, for future test and use of the feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 2b4df655d9fd0..120b96ecbd741 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -604,10 +604,11 @@ class DamonCtx:
     targets = None
     schemes = None
     kdamond = None
+    pause = None
     idx = None
 
     def __init__(self, ops='paddr', monitoring_attrs=DamonAttrs(), targets=[],
-            schemes=[]):
+            schemes=[], pause=False):
         self.ops = ops
         self.monitoring_attrs = monitoring_attrs
         self.monitoring_attrs.context = self
@@ -622,6 +623,8 @@ class DamonCtx:
             scheme.idx = idx
             scheme.context = self
 
+        self.pause=pause
+
     def sysfs_dir(self):
         return os.path.join(self.kdamond.sysfs_dir(), 'contexts',
                 '%d' % self.idx)
@@ -662,6 +665,11 @@ class DamonCtx:
             err = scheme.stage()
             if err is not None:
                 return err
+
+        err = write_file(os.path.join(self.sysfs_dir(), 'pause'), self.pause)
+        if err is not None:
+            return err
+
         return None
 
 class Kdamond:
-- 
2.47.3
