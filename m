Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059592BEC5F
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345418; cv=none; b=Z9yh1UgN66xozJF/JCnSeRuekabV4vMO2VyuW5ddyZCVagmJhQI1OQZxvnkZjnA68finb9diYPeX3wHOvPN9koXRu4CvNP90vqvjo7GjjflKqmiT3teVMTHPBa7FPldrQnIr+RGstQwvMpapuzU2ej3u3HVPqQiD757uSAzLwQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345418; c=relaxed/simple;
	bh=lvmzbjmSLHuPrSg9i6keondBkuMGzwiG4BXn0yA+cBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4vRUu4PUO89TZVUUm0tLxnp3UonvZnJLIzforxybpknMV3hsBd/VZTimDGy2JpyAzeGj88wtd2z0vIiG2T3TY5/pfh2GC/GIO3AquB/2FXzmsVd2mDYhKo9eLvHOOuGGODlZ7PLz7njSuwv1hWnqRtuLfLd4iZb5Z/x8whg7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oph9/hLB; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oph9/hLB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hQ
	UpE0Csfah/M8uxVY62fBjrw6KwaN/+M0p9wa2ysCE=; b=oph9/hLBUNqNGHlYsA
	yVrpKumUqFLle8jezuyTaNda2gyzQBAmrWIQCLQkeKIGAiMVYdHA7MPtPxw/ij3o
	Ilm64A9NYviaggNuvhkbOJSZkP16aAwQa2LBWxCzrYJXcce8+YOsgS3sXZSKN3Wl
	1fQ60FI+Lu9nv1VO9DRMdqpzM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3X9XqsEtq_MxpHg--.52234S2;
	Mon, 06 Jul 2026 21:43:06 +0800 (CST)
From: wang wei <a929244872@163.com>
To: sj@kernel.org,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wang wei <a929244872@163.com>
Subject: [PATCH] selftests/damon: check correct path in ensure_file() not_exist case
Date: Mon,  6 Jul 2026 21:43:04 +0800
Message-Id: <20260706134305.5224-1-a929244872@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X9XqsEtq_MxpHg--.52234S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryrXr13urW8Zr4rZFWDJwb_yoWkGrgEgr
	W0qrn3Aws5ZFsYyF13ZFn5ur4Yqay5Gr43uF45WrnIkry5XFs0qFykuF1DZ3Z3W3s8KasF
	9an0v3yxCr4jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRhYF3DUUUUU==
X-CM-SenderInfo: jdzsmjiuuylji6rwjhhfrp/

In the ensure_file() function, the "not_exist" code path checks
whether $dir exists as a regular file.  However, the intent is to
verify that the target file ($file) does not exist, not the $dir.
Testing $dir makes the existence check effectively useless --
it tests the wrong path and thus never catches the case
where the file is unexpectedly present.

Replace $dir with $file so the not_exist verification targets the
correct path.

Signed-off-by: wang wei <a929244872@163.com>
---
 tools/testing/selftests/damon/sysfs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 78f4badb5..bf4684d36 100755
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -67,7 +67,7 @@ ensure_file()
 			echo "$file permission: expected $permission but $perm"
 			exit 1
 		fi
-	elif [ "$to_ensure" = "not_exist" ] && [ -f "$dir" ]
+	elif [ "$to_ensure" = "not_exist" ] && [ -f "$file" ]
 	then
 		echo "$file is not expected but found"
 		exit 1
-- 
2.43.0

