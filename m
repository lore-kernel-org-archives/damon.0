Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013536;
	b=hLSc3dY6jzyrVXAY65VuRLt7P+J/Wtr2CJSg2OtZ4dNlMpyXViunub/eGUsL2Pf4J4yG
	 zcKPs43/hx0PCJDJ/+yljjucPLIeKur1cxGCnjixO79wRuU+xueh6a/m2RNIuK721nwan
	 s127xL9wdrfzG16FwBCuE6pzUZB60itx+jBk7YNg0tblrbTeCsKz1nipvd7FPpfLozctV
	 hokMSbffT+AXUPrY4Lqr7+/sVjxXTVxp8ewQW1qzxo30pa5JiUSA7XW/kalvXfnSM9Ku4
	 1iFh8KaSJp4KSWeZK9nh5l+aKzr/bqxOw9nf12YcgMVlqeUvDM0Zzm1gtaQb6rr8S2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:References;
	bh=D6FqnEFeAupUPbtnZ9Y7i7Ho9zVceUZfQGwi96SCg9I=;
	b=N/H08vXzEzZl8ZP64KvSSCzgilqciuZ2oVmsoNXFu++fKMAnh0pO4+0qdDloceSxL1eg
	 yGUU0gbXFyoZLViKHq7CGL5yGnH6ab2GvUvLTPlSAKDUxa4+0HMAC58eD+mu4fIa2B6p/
	 ZgFIyfVQYjz879hF0sT3UGDjyzp2jmULlqa+SumJiMFjj+iwttlF3DQNqrQby/b+ytCQP
	 l+ABGvpxBm6Emssc8wA7FktAbJOoYbSCGKj/BFVORDUDKbWm7koZZ0frQPDhT6r8Hy/Tq
	 CtI6A67fo1IvtVdTJohpVkFom8n7bparXLLCkTRav5HMQOUC3hljwz2hV4xVztU+qzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jOho2CwF;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B89606A31F
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39B89606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jOho2CwF
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3ada2f39f30so759642a91.0
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 04:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013534; x=1793618334; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D6FqnEFeAupUPbtnZ9Y7i7Ho9zVceUZfQGwi96SCg9I=;
        b=jOho2CwFLW38wM6dk9PveEbolc/dRkp2ek81/Ct0N53GzhbqBZrd3zgR7FcX5/Xy4o
         bG8YB3oikIYsO7g1gwOy/su0COyFbHZ5GSlg02BkUJ9++ZEoTXRLaFb5mnXCvn22k34/
         QdU0sEiJSSVMjnTKKeixn64DRmfw7Z8dsEcJAV6CnIPkU1uaV+attnrO63UlruPlp+51
         MlBRvipF9l8BIQ6mGBZtKZsEq6dcB/F1af9xK9U0jEZhITaMvxSnL9lvkF2xcH1AdULU
         vSGRz8yQwrCSSBdtcqFJ4h37RPS5FLWg2c6khaCjWDnXLUK2uJ5V8nvjF7WEUPeY/Ofb
         FM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013534; x=1793618334;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D6FqnEFeAupUPbtnZ9Y7i7Ho9zVceUZfQGwi96SCg9I=;
        b=Uq8d+S2cu2zhXfPohBlD33oF1h3DEXskVkB4mR9IqoZwHqHsMWRPmscHr3TSKHeG1/
         jK6Gi0I49/4KbS064GEwaZin+DjNmhnI7hsWESAjwXtSPYVOzWdrdfejihJ/aog4Kfw8
         bTv02nbkqNHKF1V7dJWyL0KpNYGMacsG41NIq5U5mXMtWctuxF6tRxEPvMFC4EcP5ezk
         zyfFoK2GAJe3RQgXQnadYFy9xTQkVvX+v+lHcxLgcuUnY1N7Wr9hyKafsoran1h0TbEJ
         EbO+pec55/J4tE6QUdsNVPyzPqAPP/qQ+d5GRo2iVdLOoxm3XquIEN7KDM4xAIuCt3pE
         UU1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxyBvyi6eQ/CPRsA6CqP6tG/5dXJXOr5EWHF/5wBXhos6Bcy7CMXAtFYg2F+vgRRrxIDPxxHw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ/pEw5D/UaDSlemGwW1O0ZB/vSEM37k+8nHOH68q6GERA54Y6e
	IGbRX6/bCwkgfX/LbVbN5SPCJSWvddqtQOhncejiRkytkbc2RH7jI33P
X-Gm-Gg: AYBFou1XYr6LB0oxFr/7QmzFECo/iwwnZklEnzbYfG9hti3klRDIY0iKvfGljg+fOIc
	P9RMeEbMYyRhI0yX7WfCHYXWI7bgtt+yXNXXf23U4UBBasvzr3hvEmvxI0AdZVYseIhZvjdsSiI
	Qa7E0fOdgiAN0GgxUQYvkhGiR8Cjg+P3lAQuAl2TCFKvuSBtHGyJtO6gTNNRtBe1Gb845xcuGJX
	qaQDWV6bC03Lmv57MDL2DJsXqudlFz6ViJqAQkIsc25lZRRaC3TwxTYmnREZjtoRUKqFIbjFUcJ
	oKVBhChv/Dqmkf1onsv9Qd2My8T0/wxgS/uNvZLfE0U+k/P+jh1e9DrJLXU7Q/ZejwKWPTL8vWt
	7GvJ+grDeyl7MEchW6HWMVz1CDVVzv1QmHxFL8YA5VWMQlFeU2HbMpxdeLGz9wSe6PPf9McRWxZ
	fuBvQpUr0EhM3YV7F9CbR1IiO7RcM9UBXDIpQJw60O9aV4o0yqeUokJxJuqJI28ZOfUgCQyrnkk
	55N41/dPq19uS26C+gphBXLQfQg/9zgo5Os9Hcva+4AdsCzoVJxNDWPgPZ446iXvFAyxX30UMOk
	9qgTyKT5/+qX2flXXgUMAS1NKIwtNbIRS/Q/eTzXh1zpbNPhBshr1uQ=
X-Received: by 2002:a17:90b:2742:b0:3ac:8527:3fc5 with SMTP id 98e67ed59e1d1-3ade9b2f909mr4872984a91.3.1793013534409;
        Mon, 26 Oct 2026 04:18:54 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb75254sm4783820a91.4.2026.10.26.04.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:18:54 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Manuel Ebner <manuelebnerli@mailbox.org>,
 damon@lists.linux.dev,
 linux-mm@kvack.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] Docs/admin-guide/mm/damon/usage: fix grammar
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
Date: Mon, 26 Oct 2026 22:14:35 +1100
Message-ID: <179301327249.2.6830202812762243627.damon-docs-grammar-3@gmail.com>
In-Reply-To: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>
References: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>

Fix a handful of grammar mistakes in the usage doc, mostly
subject-verb agreement and a missing or extra "be".  Also turn "Below
commands applies" into "The commands below apply", which I think reads
better.  Rewrap where the lines got too long.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 31 ++++++++++----------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 3c4f3651a244..ffb487defa22 100644
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
@@ -163,7 +163,7 @@ Users can write below commands for the kdamond to the ``state`` file.
 - ``on``: Start running.
 - ``off``: Stop running.
 - ``commit``: Read the user inputs in the sysfs files except ``state`` file
-  again.  Monitoring :ref:`target region <sysfs_regions>` inputs are also be
+  again.  Monitoring :ref:`target region <sysfs_regions>` inputs are also
   ignored if no target region is specified.
 - ``update_tuned_intervals``: Update the contents of ``sample_us`` and
   ``aggr_us`` files of the kdamond with the auto-tuning applied ``sampling
@@ -258,7 +258,7 @@ writing to and reading from the files.
 
 Under ``nr_regions`` directory, two files for the lower-bound and upper-bound
 of DAMON's monitoring regions (``min`` and ``max``, respectively), which
-controls the monitoring overhead, exist.  You can set and get the values by
+control the monitoring overhead, exist.  You can set and get the values by
 writing to and reading from the files.
 
 For more details about the intervals and monitoring regions range, please refer
@@ -310,7 +310,7 @@ Under the directory, four files for the auto-tuning control, namely
 Please refer to  the :ref:`design document of the feature
 <damon_design_monitoring_intervals_autotuning>` for the internal of the tuning
 mechanism.  Reading and writing the four files under ``intervals_goal``
-directory shows and updates the tuning parameters that described in the
+directory shows and updates the tuning parameters that are described in the
 :ref:`design doc <damon_design_monitoring_intervals_autotuning>` with the same
 names.  The tuning starts with the user-set ``sample_us`` and ``aggr_us``.  The
 tuning-applied current values of the two intervals can be read from the
@@ -538,8 +538,8 @@ Among the multiple feedback, the best one is used.
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
@@ -577,8 +577,9 @@ DAMON-based operation scheme.
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
@@ -654,16 +655,16 @@ Users can write and read the identifier of the destination to ``id`` file.
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
 
@@ -722,15 +723,15 @@ tried_regions/<N>/probes/
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
