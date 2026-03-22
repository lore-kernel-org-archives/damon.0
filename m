Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13998369215;
	Sun, 22 Mar 2026 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774195060; cv=none; b=cI0ZBie30W6J2Cie2VJNdt08dMiyHuGRq2lk3JGwg4fl3yT3IFdWVvfc4cJsCIryYJGAfLZHtTz/kBz6YJ6twXmGf5z80bF5R8plySoEDtYt95rYM/LjZIJSvm7Z6G0dDq8e93rCqld6ZEcsW2Gus5bbOsWVKpe+BM5RiUmQ8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774195060; c=relaxed/simple;
	bh=TJXeffpmshBn5e3s77gk9ewA/YmV5afqYkZ0L4RsmNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plTxos8lxey6fJ2BEYRIG8iRVoGlm0XllnvGRP9RUrSkraktXgvHnkilAMgHT9NX7bmSbCpeif/GFqI2KyATqpBXhgSqME9a7Xx57BffdRH9k3K/ZVfA6gtoyOrKe37KObN998LVr4bDvwWQH81zqhqZvlhCy3W0AJ08+k/B678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHJ2sj23; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHJ2sj23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E5EC2BC9E;
	Sun, 22 Mar 2026 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774195059;
	bh=TJXeffpmshBn5e3s77gk9ewA/YmV5afqYkZ0L4RsmNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHJ2sj23DigXs7UNnB8scp4b1R5teRP/kfsRblrOXT7t1dgqcFt5alC5ubkPWIj4c
	 1sXN65f6+trlmBlZPz6r3+vsWsif5v4IZZYk8dB1FrdWpUEaiBfQTjxnhzANzUcZJP
	 0o9oVNsYVYpCYuRYJE5Ma5VSF4zVp42KoVIAM8gVr36aUdt8p02IaiOgpRZuPVx/oq
	 3g+otQEoBe5QZR2jDxEUN811UKlSXt/mW4UImEf0j5PWVkoUumF1b2F9cHoPzNYi0Z
	 bIl5ukJdyDPjmeA1WK2EFQWXz8uNJJq/BIo2YtN1h7ADYrZGcL93LQTTxFKCqHln88
	 6rSxrr2ZhZ+Cw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 07/10] selftests/damon/_damon_sysfs: support pause file staging
Date: Sun, 22 Mar 2026 08:57:21 -0700
Message-ID: <20260322155728.81434-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322155728.81434-1-sj@kernel.org>
References: <20260322155728.81434-1-sj@kernel.org>
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
