Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478384;
	b=PJmPjhVmpbSeJlFwAH4NX20y/vwUqBOPPYDp1n8AGuXIZ9Mr8OjT7dRSGnRuABShP2rc
	 tcWeQ01PjHD41NeKRRR15090vf6X/F+QG2mPXgMVKMph/x55JM1ICtWH8iKW1WAASy3kU
	 I30Zon9isciIGl9jp8HJf3cqpNWOyzYWm16GVJgV4AVyKC91MxmRAazGBCo+DUUBOgfyc
	 wDY4z2GGW/rOocTEFqa6SZ+ZGvOA4ILq0QxicCWzN6Q4+ZIYHWsekA1aRSzBsv4hiunqX
	 9QXVOIlbsiolw5xdj298f+C0l5bS+zdzfyv9oPNXm4G526JudKb9nZbTu1wP3u2fQYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=70C4Ph3UTf6cW+VymDmG9zqM2mh9k5ZlsNQ24H+enrI=;
	b=BoKy8FuKcQFYRDxJJE4BSV8FQNufWKh6/LffFCrSB3imZkp/avG010yeabgdnpNV57SG
	 9QwMBkyQIWp3K7SRQPtY31l2oXY5V4uRm5qH5lEBp/K5sqUA0ZG/id7P8C0mQ6hNQwARc
	 aszLaAh+9i+k0DORLIuYP8/wgSfUVkTLUncZYmeslRVPRfizisK04e+ix7vyxL15M95HE
	 WJ3pU5DbUTOE5lZY8yO5MBv8LhKa9Df9Ve+CS87nbEXgWTJvedurSteJ6KLpbuTDgzJ0F
	 wsMDL+KQFXbA/gBIh8kJXK8gVj+pfACxiGQRKXAc1vY4ICZOpewEMIxlg5KiGTCprIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xmf1ZoGy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982B606A32A;
	Sat, 31 Oct 2026 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xmf1ZoGy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D121F00A17;
	Sat, 31 Oct 2026 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793478384;
	bh=70C4Ph3UTf6cW+VymDmG9zqM2mh9k5ZlsNQ24H+enrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xmf1ZoGylTJ7V7s8tHeeR5xjfQystGY8ac/LppuY+XFyKUcX4h4p3yCAx0yJhK59M
	 pQDoEkGjcbBAdphannF7mt1f6uGhWHfaNXUviR2tszW0CwUI2WIQPF3cvsKh82FdF9
	 KiyC4f6ZuBrCb9BRXbo6eHavlHFfBXkKbEJD2VmYAlXnZZwY7QyleQCFjCc6klxgTI
	 jXY9//+47DH84Z8C9j+n2UIL6/jUlqq9BRO7xcGUyPft+GR1YcMUKZCOYesgpOHUrW
	 aN4w36ja7orqBNxLPV6QgNFD5mFSNdHq9MxbEN+9ETcaE2A0sp3x8ZQHkn+EZA4xyZ
	 z+PZJtgQa59rg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/6] selftests/damon: remove unused imports of os and sys modules
Date: Sat, 31 Oct 2026 13:26:13 -0700
Message-ID: <20261031202614.96036-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031202614.96036-1-sj@kernel.org>
References: <20261031202614.96036-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs_no_op_commit_break.py imports os module but never uses it.
sysfs_update_schemes_tried_regions_hang imports the sys module but never
uses it.  Remove the unnecessary imports.

The issue is found using flake8.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs_no_op_commit_break.py        | 1 -
 .../selftests/damon/sysfs_update_schemes_tried_regions_hang.py   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
index 81774ddc55ac4..5664f75186bac 100755
--- a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
+++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
@@ -4,7 +4,6 @@
 import json
 import os
 import subprocess
-import sys
 
 import _damon_sysfs
 
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
index 625761c243b58..326a14f040534 100755
--- a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
@@ -4,7 +4,6 @@
 import os
 import subprocess
 import sys
-import time
 
 sys.path.append(os.path.dirname(os.path.abspath(__file__)))
 import _damon_sysfs
-- 
2.47.3
