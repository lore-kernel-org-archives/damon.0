Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F045D342524;
	Sat, 21 Mar 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774116835; cv=none; b=o1Sfj6VuT84n4KwAABAy4P4VO8kykZTgSCA1sDtapvGUOy10pVOSYBovVEny0zKG8mqMCr8+sAlhw3xf4qZpcWqKBz1FP/SWZ8jZHGh4mdBTEVI8zxUnSvlXf9S3gW5nY73j5K4rvkE+3M/dv2b50C1izMhKW1zwgpBRt7RHnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774116835; c=relaxed/simple;
	bh=TJXeffpmshBn5e3s77gk9ewA/YmV5afqYkZ0L4RsmNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkC8EbYmTN9QZkjQXPBII4/EXYgCDaNNLnqh7FlsmCuyN16flVsPAaJUBdK+tc0q5cfKN++fPlZKzgEIdtR5sV8zvHX4zMjJfJqnKxjenUunwWksq8HuVscXSDEgBNw61OmvvXuzF9bP16Bux0cM42N51MCnQAHWkzRyBebg4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT2FwYha; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT2FwYha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7367C4AF0B;
	Sat, 21 Mar 2026 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774116834;
	bh=TJXeffpmshBn5e3s77gk9ewA/YmV5afqYkZ0L4RsmNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sT2FwYha5tiOMbwsOEicRBMnwu3gOCjkbkwjo3CYq6MEfzc4PXwO0GPSbLTv0+/SV
	 XHBdr7za67mbduLwqkL4MtU8KH+Sh3JBu+nV05kpxOy0AdXc3C0y+kVAB/yq6KWbGD
	 SyxqCWh2JylLIXrSffzmE8ujN2QWWVCAp35aEh3MaDmhNV2NNTs2jthjcRX6gqrSVK
	 Sr/HehNOkcVXgc+SpL0JH/ov8dg0LszJo5Uh2Xpyxdbt9ZTCcuXeErzb4P+okUuk5r
	 pBpinHMaRBasek86/kDpHmL1DCCyO1EPgjtqs+b95C2T3rHWgVLj8DgoLtbKOIIRdH
	 vREyyTH2BDzzw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/10] selftests/damon/_damon_sysfs: support pause file staging
Date: Sat, 21 Mar 2026 11:13:37 -0700
Message-ID: <20260321181343.93971-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321181343.93971-1-sj@kernel.org>
References: <20260321181343.93971-1-sj@kernel.org>
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
