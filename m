Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553400;
	b=IME3IP+v+HUALA6KN0//DgtHv3D+FacJXaiECdDi5WoW0RDC6G+s2TcpQ0FCJB9kbkYy
	 T0YKX5+vOISac0nUsVySQTi9OWdG1B0OMTYFxKTZqdBpO5lSO7dJksSfKJxDts4KSC7O5
	 tJi0yy6nb2pbYIJaI3jIPsDT6l1+vNcNAy758h5L/x07AtHYL5AOi9ZAlCQ9ydfENrcIS
	 c/Tx94gjKfHNq9JjmXzl+4wRt2yh0U1wJt1Hc5/vs4LjzaVNmOgMb5ApbVlOpF6nrxzfU
	 u7LhECgcD6avLKoPOrKGNHPPMkFjqjeByRq2rOM1FhZg0/JsCIpDk3I7csaHq/dke+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553400;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3UDKAp2uds0+N1mENd7M+9zX167leKiazEipp95Aa0Y=;
	b=xeyR4TVbZb3w/ILcAy4KUNzFtXQtqNOM6bSkiOSMlD6WAOWInC4DSPPnItoqkTTeXW4B
	 IQ+M0Cbe9bwfZpSs+msFJm1QC8jkF5SmogLAfOYjaxs3uismTziwd3ebvdF0AfboMYBqj
	 +1NALQYgASxumon6BRH8nBdvvwzX0d0SQAkSNl+vosEjMxHrc/yrEWzInmsTld8Ruppj5
	 BUrbst9i6N+cRy1yv0OMceDLhT4P79BaaXgloAJmCd+R1RP9KP+YIYJe8+8lGRom3hEkm
	 EH0A8KhmCLmXMYMvinDsKFCv9g4j2q1CtHXdzqNbUo4fnFcofCllMdkHPSKoPhSN41A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0IMbOAc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FA5606A329;
	Sun,  1 Nov 2026 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0IMbOAc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1503F1F00A1A;
	Sun,  1 Nov 2026 17:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793553400;
	bh=3UDKAp2uds0+N1mENd7M+9zX167leKiazEipp95Aa0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m0IMbOAcMMiKvuFVTPYx+cflpos0ecUDnB1EYU6un5dMopyB01p6xMV4xOJ+dF/sf
	 cJVxsAwMJnhtM5u705PX/HFQJklyi0WRsCXChlo3oxCqqKNxFyDMyGqKO/zv4XIvjF
	 Pneh15gdgH5LcrpPtdtFkLkVaIpKZ+yFTO/wvxcHt52ib+8FzC6Q6Di6FbUSvlvyry
	 U6qnkTXCUxOvAc47JyOro8hDTEUgfoa4fxw9rcAgl40FXw7A2K9ODApmyCROJJKNRP
	 l9uQHGmiOktl3Vr2vVI8v6xNnjG3Ne5/JI4NAkjnT53zHKjVzXBRq6EUEJ1S9qRn9z
	 rsTBFf7wt96aA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 6/6] selftests/damon: remove unused imports of os and sys modules
Date: Sun,  1 Nov 2026 09:16:29 -0800
Message-ID: <20261101171630.81477-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101171630.81477-1-sj@kernel.org>
References: <20261101171630.81477-1-sj@kernel.org>
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
