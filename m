Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667590;
	b=SX2Ia86wXSmC8lIAm9Dzlj6gO3qsTTcSC57BPnzrgiiX+cThZIkJf1LRSOnOOsXxFjtq
	 A8zQWZuxlrug54LesybmpoFO00cOgqrH8iuo1QojptAmFb0na9m3aemow7RxDTYUdXipN
	 U7lLy3x2h6D0Oflc+i3PB2tHnEYVyLQR6bXhw8c0NbaDIdw4E5nQuL7a13/EcM1V44JJt
	 t66vmnRE1jVtmu0K40U8kFAaLynDcf6Ma8uHXoM3LBWwk+SiN2jdjVh/ZpYsDt4XKr4wC
	 EkczHAEiYUNRE8Vowu39wUDmg8Mq76VOsmBFFIJR6mWY6P7id+JSyPSInzJDEgyMRuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667590;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eAIEk27vq7SBMU3eK04a7ELsfUgkQKJdZcdW3LgEO4Y=;
	b=suiSAv+hDV8XRQhHlYpGsLDEkZwa6P59nG3g55vnyclZErIfVh1b9swdvhhEucEf8Ese
	 Vy2+ItgV18n7pb+5XRImj5cImBblWqrdtVy5s8uPzWDmclWHVNy8eIx/00+xDZD14bnwr
	 7z0HG+euJ2w3sD+Nw8qiO0mxoB1umU9LyLV5dtUzPazU7haIRPaZirArmdMGsPEtVyRbj
	 n/tyy8Md8WcRcWgS1b8QVMtP6wsRB7PC+mZG4oToowHJoTWvGAI2zXPlGx+dG0KxOgsRb
	 wVq2kZbEIiFesKafwlU5Ci2D6LiMmqXW3s9M/Zhdf+zvd1W5Sv77gJA2Lq1QxiUhZ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILFSQTAa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0E606D807;
	Tue,  3 Nov 2026 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILFSQTAa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E02F1F0093A;
	Tue,  3 Nov 2026 00:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667589;
	bh=eAIEk27vq7SBMU3eK04a7ELsfUgkQKJdZcdW3LgEO4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ILFSQTAaF6kJrx/TYSoWIT/QtO9KF/QFp2Zk8INMjPaYjb2f+UqWTET9sOtVdHKdQ
	 m8TZi2CIjLtn+FhaonI+i17T/s7K09H8tj71lT+I1Mq3hA7A692+pBT5oRytXct5YY
	 +wZT6hXli590DAaPdla5HkprTqm1LdFV9J/4G8f/Z1Cra8pCKyh3FAy76gQiJixkTC
	 vR7if78QAz+tbYCvCeLfpWujf713hFllfnpeAD+d2ndXzjnASNLxfqQHMkQrXGyzTz
	 etgyoOVKLJMp/HIZnuT6wIqfKl1fpgCA/WuaZPueIUHxZdNsB5uoReJXdCKgwt+uWx
	 6Jx/1Qz/yrgxQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/8] Docs/admin-guide/mm/damon/usage: fix grammar
Date: Mon,  2 Nov 2026 16:59:33 -0800
Message-ID: <20261103005940.91432-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103005940.91432-1-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aveline Noir <jm5905938@gmail.com>

Fix a handful of grammar mistakes in the usage doc, mostly
subject-verb agreement and a missing or extra "be".  Also turn "Below
commands applies" into "The commands below apply", which I think reads
better.  Rewrap where the lines got too long.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 31 ++++++++++----------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index bd687d89ea4c0..cc7465251bb6f 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -23,7 +23,7 @@ DAMON provides below interfaces for different users.
   want more optimized use of DAMON.  Using this, users can use DAMON’s major
   features by reading from and writing to special sysfs files.  Therefore,
   you can write and use your personalized DAMON sysfs wrapper programs that
-  reads/writes the sysfs files instead of you.  The `DAMON user space tool
+  read/write the sysfs files instead of you.  The `DAMON user space tool
   <https://github.com/damonitor/damo>`_ is one example of such programs.
 - *Kernel Space Programming Interface.*
   :doc:`This </mm/damon/api>` is for kernel space programmers.  Using this,
@@ -155,7 +155,7 @@ Users can write below commands for the kdamond to the ``state`` file.
 - ``on``: Start running.
 - ``off``: Stop running.
 - ``commit``: Read the user inputs in the sysfs files except ``state`` file
-  again.  Monitoring :ref:`target region <sysfs_regions>` inputs are also be
+  again.  Monitoring :ref:`target region <sysfs_regions>` inputs are also
   ignored if no target region is specified.
 - ``update_tuned_intervals``: Update the contents of ``sample_us`` and
   ``aggr_us`` files of the kdamond with the auto-tuning applied ``sampling
@@ -250,7 +250,7 @@ writing to and reading from the files.
 
 Under ``nr_regions`` directory, two files for the lower-bound and upper-bound
 of DAMON's monitoring regions (``min`` and ``max``, respectively), which
-controls the monitoring overhead, exist.  You can set and get the values by
+control the monitoring overhead, exist.  You can set and get the values by
 writing to and reading from the files.
 
 For more details about the intervals and monitoring regions range, please refer
@@ -268,7 +268,7 @@ Under the directory, four files for the auto-tuning control, namely
 Please refer to  the :ref:`design document of the feature
 <damon_design_monitoring_intervals_autotuning>` for the internal of the tuning
 mechanism.  Reading and writing the four files under ``intervals_goal``
-directory shows and updates the tuning parameters that described in the
+directory shows and updates the tuning parameters that are described in the
 :ref:`design doc <damon_design_monitoring_intervals_autotuning>` with the same
 names.  The tuning starts with the user-set ``sample_us`` and ``aggr_us``.  The
 tuning-applied current values of the two intervals can be read from the
@@ -496,8 +496,8 @@ Among the multiple feedback, the best one is used.
 Each goal directory contains six files, namely ``target_metric``,
 ``complement``, ``target_value``, ``current_value``, ``nid``, and ``path``.
 Users can set and get the six parameters for the quota auto-tuning goals that
-specified on the :ref:`design doc <damon_design_damos_quotas_auto_tuning>` by
-writing to and reading from each of the files.  Because the kernel does not
+are specified on the :ref:`design doc <damon_design_damos_quotas_auto_tuning>`
+by writing to and reading from each of the files.  Because the kernel does not
 update ``current_value``, reading it only makes sense when ``target_metric`` is
 ``user_input``.  Note that users should further write
 ``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
@@ -535,8 +535,9 @@ DAMON-based operation scheme.
 ``core_filters`` and ``ops_filters`` directories are for the filters handled by
 the DAMON core layer and operations set layer, respectively.  ``filters``
 directory can be used for installing filters regardless of their handled
-layers.  Filters that requested by ``core_filters`` and ``ops_filters`` will be
-installed before those of ``filters``.  All three directories have same files.
+layers.  Filters that are requested by ``core_filters`` and ``ops_filters`` will
+be installed before those of ``filters``.  All three directories have same
+files.
 
 Use of ``filters`` directory can make filters evaluation orders confusing to
 expect.  For this reason, ``filters`` directory is deprecated.  It is still
@@ -612,16 +613,16 @@ Users can write and read the identifier of the destination to ``id`` file.
 For ``DAMOS_MIGRATE_{HOT,COLD}`` actions, the migrate destination node's node
 id should be written to ``id`` file.  Users can write and read the weight of
 the destination among the given destinations to the ``weight`` file.  The
-weight can be an arbitrary integer.  When DAMOS apply the action to each entity
-of the memory region, it will select the destination of the action based on the
-relative weights of the destinations.
+weight can be an arbitrary integer.  When DAMOS applies the action to each
+entity of the memory region, it will select the destination of the action based
+on the relative weights of the destinations.
 
 .. _sysfs_schemes_stats:
 
 schemes/<N>/stats/
 ------------------
 
-DAMON counts statistics for each scheme.  This statistics can be used for
+DAMON counts statistics for each scheme.  These statistics can be used for
 online analysis or tuning of the schemes.  Refer to :ref:`design doc
 <damon_design_damos_stat>` for more details about the stats.
 
@@ -680,15 +681,15 @@ tried_regions/<N>/probes/
 -------------------------
 
 In each region directory, one directory (``probes``) also exists.  In the
-directory, subdirectories named ``0`` to ``N-1`` exists.  ``N`` is the number
-of installed probes.  In each number-named directory, a file (``hits``) exist.
+directory, subdirectories named ``0`` to ``N-1`` exist.  ``N`` is the number
+of installed probes.  In each number-named directory, a file (``hits``) exists.
 Reading the file shows the number of data attributes monitoring probe-hit
 positive samples of the region.
 
 Example
 ~~~~~~~
 
-Below commands applies a scheme saying "If a memory region of size in [4KiB,
+The commands below apply a scheme saying "If a memory region of size in [4KiB,
 8KiB] is showing accesses per aggregate interval in [0, 5] for aggregate
 interval in [10, 20], page out the region.  For the paging out, use only up to
 10ms per second, and also don't page out more than 1GiB per second.  Under the
-- 
2.47.3
