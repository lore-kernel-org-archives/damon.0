Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DDF1A23B9
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022845; cv=none; b=IcsdFWch/vt6TzQi5GR35BRVF/qDFEHI5z05dyo/8onbGiyKqp1lV1bIi8zhbCKINvZkonh5JJYqz1CjbQiQX7tQ6yKLuKb7LOS8XE10303Z1AANWa+rhnUc4jbS6mM31/hvD1UuKTfWc5Ozrk3cVkWkRYjlp4iU1lxSpJaGXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022845; c=relaxed/simple;
	bh=IsxDvUOlPC/SNQd1/+tcnpC3Es95w6IQg+qyLyewcNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lh/z4sxMy4RPxxygq1zuR1TURuvXaSgeHs81IZfV+/lMUxtb9b7ciUJcX5rbjvgCC9n8YEP3wv45pQWcmnsU1kFmlDZOAZeOutCzcj4iRKedChchN/tG2ig8XePOlZg3KmG8LUjAwqn7Rsz0jgD+1vYDJ2ryrnE2yyGy3oAuhwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSTqIq7X; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSTqIq7X"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8600a33792so3465695276.0
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 18:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022843; x=1752627643; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2jsjg4EouOhcgExOsiiXXDMU3g5WamEv1plw5aSp2k=;
        b=dSTqIq7XQqAo3O7CcCF5WOKRNT3Ul7CHThqlTELCR1/anEZKHDCi2z5+NitZUEtbtN
         dNpt6xihaFjaeSXgGn8lRtXi/Blk/yp08uSbLco/oXSOoPW11UhBYwYku/pTJSk897EV
         kJXnPULYbXA6nwFhpk7nUI+5qNpNfSyKVrPIFzHsgBSY/pa+pYAhhncuiS+l6ErCqUjh
         YsK2QtKpxTfIe5ZXyvQ1sSFDx5V67nj8ic+xsuBzu9GYd8DH/28p70Kc5KVBHx7A5yhD
         Q4x6AYsBI+M9l0Li1kNtJfQor/PR95ygfksK/2aHftaqVmUzQxQG8Jrn/ZpqrzX1ojk/
         SIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022843; x=1752627643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2jsjg4EouOhcgExOsiiXXDMU3g5WamEv1plw5aSp2k=;
        b=s16tRY0bght8De6+qasun7iqHtlQ08KPe6Ymx48OHTXQP9hiKBjy/93QrTRFSNpJ+I
         MBwNptV3fZYNPZcIVADJNBRlx9Tn3DJqEDWf4etz1cklvyGrtensNsvXWDzgHO9nSePM
         2SZUBqcF6RJtA32eikqgZSVmDq3ACi4iYxxIoKT8Je0j2JTkzdoQ+MY2gqJeuAGfMURU
         dyawDpu35DNNSeAhrjJvLyWzGBJgu4DBXWirdy/9Nkrd1idojWqscgc3zRB72b3b5o1H
         ipBWNXct0Jj2I73N1OX8qkMNk1ow3qxfmx/DaBqgWnWxdUucuESEeFAsuktS9f/u/LEv
         yrtQ==
X-Gm-Message-State: AOJu0YzBbC70W3viJ3AmiW2DFNasZa+iGZ4TAJ3Dzu+3j+YGOaE0SA27
	/ESksVijESahcJHK+aGwHia/0iBFAB6hPUjjxyrazvRDx/q6W59sqZOU+1J5G4lEJFU=
X-Gm-Gg: ASbGnctoUWZ9j+/MQCvoSuOYbY6DoacgIsxYNu6igdGvgktX5MkLgrnWanja5eYok/P
	VpEdwaqaKAhQXI0RuqIJcyzqqf6Qej2MgY2tLHKmU4kobjbg8c/JwJyz5n9A5xdG/VeQk96f4AF
	AUIIRCo7InjRFOy1Ko1blBlihbfE5d4WvtG2feU9kWjotEsOYVWRKQqYCus/5PmzlAdDc87qP4i
	ihbcpvw/lc7ZDUCButVtQHk+HxYK1jGu60qpC0eNQQWPSxpobmJXBFhv+4bnnJICJwCAQukZ5m6
	TePEe4mDLeVYyqaolQjt5vOZ336bVV95dklaKcYa2vCeYOIdTsLlimvlMY9dtTOWZC4mCL31/uI
	gpH1M+UQ=
X-Google-Smtp-Source: AGHT+IG9eIe5dClap9KCxt/8jsEpzJHg4xsuwYOTV9E8tYS1KG14U14qxbM4oZ2qYkqz80lDz0BJew==
X-Received: by 2002:a05:6902:2c05:b0:e87:982c:5528 with SMTP id 3f1490d57ef6-e8b6e151739mr662630276.40.1752022842295;
        Tue, 08 Jul 2025 18:00:42 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:41 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com
Subject: [PATCH v4 06/13] Docs/admin-guide/mm/damon/usage: document dests directory
Date: Tue,  8 Jul 2025 19:59:36 -0500
Message-ID: <20250709005952.17776-7-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Document the newly added DAMOS action destination directory of the DAMON
sysfs interface on the usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 33 +++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d960aba72b82..fc5c962353ed 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -85,6 +85,8 @@ comma (",").
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
+    │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
+    │ │ │ │ │ │ │ │ 0/id,weight
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
@@ -307,10 +309,10 @@ to ``N-1``.  Each directory represents each DAMON-based operation scheme.
 schemes/<N>/
 ------------
 
-In each scheme directory, seven directories (``access_pattern``, ``quotas``,
-``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``stats``, and
-``tried_regions``) and three files (``action``, ``target_nid`` and
-``apply_interval``) exist.
+In each scheme directory, eight directories (``access_pattern``, ``quotas``,
+``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``dests``,
+``stats``, and ``tried_regions``) and three files (``action``, ``target_nid``
+and ``apply_interval``) exist.
 
 The ``action`` file is for setting and getting the scheme's :ref:`action
 <damon_design_damos_action>`.  The keywords that can be written to and read
@@ -484,6 +486,29 @@ Refer to the :ref:`DAMOS filters design documentation
 of different ``allow`` works, when each of the filters are supported, and
 differences on stats.
 
+.. _damon_sysfs_dests:
+
+schemes/<N>/dests/
+------------------
+
+Directory for specifying the destinations of given DAMON-based operation
+scheme's action.  This directory is ignored if the action of the given scheme
+is not supporting multiple destinations.  Only ``DAMOS_MIGRATE_{HOT,COLD}``
+actions are supporting multiple destinations.
+
+In the beginning, the directory has only one file, ``nr_dests``.  Writing a
+number (``N``) to the file creates the number of child directories named ``0``
+to ``N-1``.  Each directory represents each action destination.
+
+Each destination directory contains two files, namely ``id`` and ``weight``.
+Users can write and read the identifier of the destination to ``id`` file.
+For ``DAMOS_MIGRATE_{HOT,COLD}`` actions, the migrate destination node's node
+id should be written to ``id`` file.  Users can write and read the weight of
+the destination among the given destinations to the ``weight`` file.  The
+weight can be an arbitrary integer.  When DAMOS apply the action to each entity
+of the memory region, it will select the destination of the action based on the
+relative weights of the destinations.
+
 .. _sysfs_schemes_stats:
 
 schemes/<N>/stats/
-- 
2.43.0

