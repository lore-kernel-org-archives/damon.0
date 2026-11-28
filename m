Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795892442;
	b=fHNRpcCDBiiXD3Ye2Rk0QUgeCLoBOj7ubrwq2uWDjplPs2WcimyJ7cxWMZCKHu0vZQg5
	 KMXUSPufZtM31CQo3771180x1PP16UXWTgfz3AwoFcnGvvV3QOsVbk4VgfAiqFqo20hho
	 stIKYfPtA/AGN1kYROLeqoI8Dj7PdjpNIICTtk1PYE8aexZhNmTiAYsEzWUHuVhuBlw2a
	 aN0rBay6/8lglL566ZZwJbTH0Ma1mUohIrcARYxCxZnS0klmGq566/WJ7McpBh8L7Eai/
	 VSZKxj1km2qrdO1EX5krqpMK59+xIVOqbIbtfWIEKo44fMRQryA513EBKDHAUf3u+ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795892442;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o7wpSeL6G0QpGcEme2lV9PTUvLXdPq2HjfhafRLkksA=;
	b=4qS1Wct0gRdL+vycKa8UmSX5qdZz5JgOfrpcptSnT40TX7DD4rtTnegnRa2+EczwY2RG
	 YQoX5ogh6uxERzZX9m8CYc8nc8z4GCT6QsSepmBVHK1eMFwkCoK4wXCfHtsXzkZBbD1O1
	 1lCVOHFRHnXEaHhM7u5uCz3wEzh9bISTf3yKGhmfQOph7QklYtSvsf+Nt9y/auob/A7qj
	 q+iY1kHASHxNTjcSDxwcjRAEE0KRqqdwTeT+9yuxg9Rlj+tPbAFYCsQwzjjKO81d600BW
	 HyNHd308KCyQcacIgAUJjsvucIXocSrs8hmVjg7hNO3mWfYvfW/jOXnL2iG6K3H2Y6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cr1rwdTw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E45606A31C;
	Sat, 28 Nov 2026 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cr1rwdTw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BED61F000C1;
	Sat, 28 Nov 2026 19:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795892442;
	bh=o7wpSeL6G0QpGcEme2lV9PTUvLXdPq2HjfhafRLkksA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cr1rwdTw9zz0OqAA1vysLjy6R89wFhEArHGtPUQX9i9FxY6IM3o1zw+fbS43mzzWH
	 jmzsvjVZ3H8nVBNsUHsX+xs6jFhT7Sg8GPqxsqEtltVQkJaCFToB1kv19k3F2YI9tJ
	 zmWklA24J8e9XFsUE5MWYhcagujyQ1/kM2E6f+03iz16FLwcCQgGqfe/VWHMCndruX
	 3+WEFKv2QLJxFBp/DiVTyx7MgC3oWoEGDQomwojKZEEAkhidhLkrOfc/R8cL00ACi2
	 iUZZWwf50VdS0dOJBbSEs+P8RK3brv0pR0mcdg25FNXC7wFItp1rW+D57GOXaCp7XJ
	 KpOGx7jSnU/Xw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 6/7] selftests/damon: remove unused imports of sys and time modules
Date: Sat, 28 Nov 2026 11:00:31 -0800
Message-ID: <20261128190033.164440-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261128190033.164440-1-sj@kernel.org>
References: <20261128190033.164440-1-sj@kernel.org>
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

sysfs_no_op_commit_break.py imports 'sys' module but never uses it.
sysfs_update_schemes_tried_regions_hang imports 'time' module but never
uses it.  Remove the unnecessary imports.

The issue is found using flake8.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs_no_op_commit_break.py        | 1 -
 .../selftests/damon/sysfs_update_schemes_tried_regions_hang.py   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
index 81774ddc55ac..5664f75186ba 100755
--- a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
+++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
@@ -4,7 +4,6 @@
 import json
 import os
 import subprocess
-import sys
 
 import _damon_sysfs
 
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
index 625761c243b5..326a14f04053 100755
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
