Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80F16FF44;
	Mon,  1 Jul 2024 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862034; cv=none; b=Y8ydFRjpKCSYPR7H+glYQF45e7SHiMRsD0DfqK3HH5OqUc56HaNST49ebhBAbhc/kJCkOYlMEX72dl3EWTZJNF+8MFcw5LYrQarvFQib5G2sqh7qJ4WLRo0QllHTP+PTA/rTTwe/3qzdvY5t0hRc+Mfm5MmpXY6DpIZlbDxfZjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862034; c=relaxed/simple;
	bh=xIHZ0L/qw5eQQs5fbReQPpk6P9pGxGMQqK3yOrF7MWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1NelJ2uzubn/8u+R8fKxpAX8CpXxBggGxhkEx5oo+7MJYqN9iuF6Q+yRUbitMHASfTCe/nEGSKC/BpttMyh8lZuTgwGePLTPj4locGvJ+h0qG7iRR0ElEU9P7V2nEpkm6iwGMChuk2i48F/uYn/jVvL6dWrzz/BwN89FHRPmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+nK9tiY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+nK9tiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AC5C4AF0A;
	Mon,  1 Jul 2024 19:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719862033;
	bh=xIHZ0L/qw5eQQs5fbReQPpk6P9pGxGMQqK3yOrF7MWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+nK9tiYcgMpX53+AWbsywu8xs749rQaWCssGXzuDSadnTFeYIMlrXu0ew3T9dogi
	 IkTIfMtrF4gwrS8lz31uYJoiseCCJZBN6IK42mV5Ps+naC34CloIetMhyW+IIW0Tzm
	 a3kLjxoOisBw1iI+iRFYDLkTJ9sfD7S87UQtjomfKCfkGG2nQKLRtrEbXiCK4xBjNB
	 OxX6IPFsLg/kxTSojMTgp7r4eDXpkwob7xOWZAfAWVb9R2EKvi3clvf/8ukmnI4FaX
	 /62gWPAvoqSIs4yka7Lz/BmMO2EbhNhKKwygKrTXIXoPsFmunFbrhZahPo/WoEyVKy
	 clgLU8P1HYwIA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] Docs/admin-guide/mm/damon/start: add access pattern snapshot example
Date: Mon,  1 Jul 2024 12:27:00 -0700
Message-Id: <20240701192706.51415-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701192706.51415-1-sj@kernel.org>
References: <20240701192706.51415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON user-space tool (damo) provides access pattern snapshot feature,
which is expected to be frequently used for real time access pattern
analysis.  The snapshot output is also showing what DAMON provides
on its own, including the 'age' information.

In contrast, the recorded access patterns, which is shown as an example
usage on the quick start section, shows what users can make from what
DAMON provided.  It includes information that generated outside of DAMON
and makes the 'age' concept bit unclear.  Hence snapshot output is
easier at understanding the raw realtime output of DAMON.  Add the
snapshot usage example on the quick start section.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/start.rst | 46 ++++++++++++++++++--
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index 7aa0071ff1c3..054010a7f3d8 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -34,18 +34,56 @@ detail) of DAMON, you should ensure :doc:`sysfs </filesystems/sysfs>` is
 mounted.
 
 
+Snapshot Data Access Patterns
+=============================
+
+The commands below show the memory access pattern of a program at the moment of
+the execution. ::
+
+    $ git clone https://github.com/sjp38/masim; cd masim; make
+    $ sudo damo start "./masim ./configs/stairs.cfg --quiet"
+    $ sudo ./damo show
+    0   addr [85.541 TiB  , 85.541 TiB ) (57.707 MiB ) access 0 %   age 10.400 s
+    1   addr [85.541 TiB  , 85.542 TiB ) (413.285 MiB) access 0 %   age 11.400 s
+    2   addr [127.649 TiB , 127.649 TiB) (57.500 MiB ) access 0 %   age 1.600 s
+    3   addr [127.649 TiB , 127.649 TiB) (32.500 MiB ) access 0 %   age 500 ms
+    4   addr [127.649 TiB , 127.649 TiB) (9.535 MiB  ) access 100 % age 300 ms
+    5   addr [127.649 TiB , 127.649 TiB) (8.000 KiB  ) access 60 %  age 0 ns
+    6   addr [127.649 TiB , 127.649 TiB) (6.926 MiB  ) access 0 %   age 1 s
+    7   addr [127.998 TiB , 127.998 TiB) (120.000 KiB) access 0 %   age 11.100 s
+    8   addr [127.998 TiB , 127.998 TiB) (8.000 KiB  ) access 40 %  age 100 ms
+    9   addr [127.998 TiB , 127.998 TiB) (4.000 KiB  ) access 0 %   age 11 s
+    total size: 577.590 MiB
+    $ sudo ./damo stop
+
+The first command of the above example downloads and builds an artificial
+memory access generator program called ``masim``.  The second command asks DAMO
+to execute the artificial generator process start via the given command and
+make DAMON monitors the generator process.  The third command retrieves the
+current snapshot of the monitored access pattern of the process from DAMON and
+shows the pattern in a human readable format.
+
+Each line of the output shows which virtual address range (``addr [XX, XX)``)
+of the process is how frequently (``access XX %``) accessed for how long time
+(``age XX``).  For example, the fifth region of ~9 MiB size is being most
+frequently accessed for last 300 milliseconds.  Finally, the fourth command
+stops DAMON.
+
+Note that DAMON can monitor not only virtual address spaces but multiple types
+of address spaces including the physical address space.
+
+
 Recording Data Access Patterns
 ==============================
 
 The commands below record the memory access patterns of a program and save the
 monitoring results to a file. ::
 
-    $ git clone https://github.com/sjp38/masim
-    $ cd masim; make; ./masim ./configs/zigzag.cfg &
+    $ ./masim ./configs/zigzag.cfg &
     $ sudo damo record -o damon.data $(pidof masim)
 
-The first two lines of the commands download an artificial memory access
-generator program and run it in the background.  The generator will repeatedly
+The line of the commands run the artificial memory access
+generator program again.  The generator will repeatedly
 access two 100 MiB sized memory regions one by one.  You can substitute this
 with your real workload.  The last line asks ``damo`` to record the access
 pattern in the ``damon.data`` file.
-- 
2.39.2

