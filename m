Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AE823FC7D;
	Sun, 20 Jul 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031841; cv=none; b=o8TiU0CdAe29BdFlRePS/F1inyhbxTMFN40ZI3BKtEWXTiZPt7W7AxqUXDrfIoQ/f/VLBt2cg42aYAtGX4pMSMYQ+6Qx1wTVz/UhTCT0IknW02xOBGnrEmagpCrhdG2nvGMzkVkdc2j6XhHozguYN5PY75PsVu1u9nC+JJnUEo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031841; c=relaxed/simple;
	bh=ec6Z15ZJoYXT0bezGsQ3tUZMxWIpt+Ad5P0Bbazn0/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SsA6BYuwISjwSNlyrz9bULwUYxuZRDxxbjmTiYM899sWc+Br219o5TLj1GpDYYMSZxzCjbnYVj7tBt7Ak51g0gx5MNV5D+MUcs+APuPe0rQhoZ9E0Z/EoxJwzy2AWv+g8xYTcj+PzDdlt1uZoeBCfm1+zFCeR4pn77IkKkUtrYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTO9IfKG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTO9IfKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099ECC4CEEB;
	Sun, 20 Jul 2025 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031840;
	bh=ec6Z15ZJoYXT0bezGsQ3tUZMxWIpt+Ad5P0Bbazn0/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTO9IfKGbWqX5x3rw1bUdwOQnp45m56Gq8/NECKWuvTUZA/ojaG5UqFeflSGCly3R
	 l+62B3I4F3R5Ru27piljAXpbGMy9jBPxGRitDVbhhXuXapmIlA5/LTpfwNkOC8IgiS
	 Fwcg6+TPP92EJLUJIANcRVyC/lliAh/oVM9wWehm3ldTwc8Bw/H/xUVAbzAnWtzhCN
	 WOjPgw3Rv3f5z/TlAjQAqOZYTfUHDTix2dHslShtIdsn+UnJHLZ9X93IhiLp0IMKBQ
	 cZdNq9imtCR/tS2SQXdc/YU6VUtSMkQRKzCkLC2EysIBQHmDaj0KcycNN3PD7kmAFK
	 vV1uMsgaj1e6g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 22/22] selftests/damon/sysfs.py: test runtime reduction of DAMON parameters
Date: Sun, 20 Jul 2025 10:16:52 -0700
Message-Id: <20250720171652.92309-23-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720171652.92309-1-sj@kernel.org>
References: <20250720171652.92309-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs.py is testing if non-default additional parameters can be
committed.  Add a test case for further reducing the parameters to the
default set.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index b2cb178dda15..e0753ed92a98 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -247,6 +247,20 @@ def main():
 
     assert_ctxs_committed(kdamonds.kdamonds[0].contexts, status['contexts'])
 
+    # test online commitment of minimum context.
+    context = _damon_sysfs.DamonCtx()
+    context.idx = 0
+    context.kdamond = kdamonds.kdamonds[0]
+    kdamonds.kdamonds[0].contexts = [context]
+    kdamonds.kdamonds[0].commit()
+
+    status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print(err)
+        exit(1)
+
+    assert_ctxs_committed(kdamonds.kdamonds[0].contexts, status['contexts'])
+
     kdamonds.stop()
 
 if __name__ == '__main__':
-- 
2.39.5
