Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BB2F5C50
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487274; cv=none; b=l6qJcOumIax2o+wuaY3hyCxF/W8BaEgQYD04IKl73BH0z3HlFIjKE9J7SdfTD5yb5mIRCs1wQcIVfNXY5X8D9szg1nUixerP6znONvsgLfmlMbLvkWUwjZDaTHTpyKsUFwzB25t+u9Cqi0gfzBWb5L3zLDLXSIhPLuvNn9HWMyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487274; c=relaxed/simple;
	bh=zBWqLe/8w6jQy04hgGoAjOSCfh9MU/i5qTJrnQF83+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmUYHRF9FDaQAaIbIJ1KqxQc4RvWMiw/U4snKH2eZ8+uOU+VwmDBQnq5LBAjIAxwyQE1NtIFbDzIhdyt/hMXlsPlghbL6KvmIZU1DDIZ2uR1CqehK1FEnXei6os3YGekhOT5wLK+VPzg9DZVHL9+tj861v3JhuJVm0bh1LnCpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE9vdP0r; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE9vdP0r"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7086dcab64bso46245227b3.1
        for <damon@lists.linux.dev>; Wed, 02 Jul 2025 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487272; x=1752092072; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whp07KqijnEckNg3QoMixvcYpADgEZZkHKJXbQWF63Q=;
        b=LE9vdP0r7lnIQXDYyvMWS10ZMI10GXD6DsSbHlSgZh0Git2cTw+b6uYwYHO7saizRX
         UnGm2gPdGhhz3HmNl3eq5510UYyqVjgFsNvxMw61ncnBpOEDleW/EC7S7jQF9U0upwIy
         IWS9nbvtVwGmmuagzk0cglu2miIJJtnw1ISiHALwIBLbVpxQHX23+4MrNJPJnH2bubdz
         YAOJImotxpcfOWlFEdjAGAIQlikWIrOOy+VfCNvYzi/dTEyslceDJiahhhVkR/xv9GYO
         e5yZr+E4KUoltNOklaWKkO/LquYIf6NtVMcZg8/ZtRCc+qXMswAncU/VzYP6Fo3qfOW3
         mqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487272; x=1752092072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whp07KqijnEckNg3QoMixvcYpADgEZZkHKJXbQWF63Q=;
        b=vtc9S4c3AscA4HhQ7c7d5mIQwI1FTGRrKLyKrdcu6wOjZjodHdgPCyTNW+YFoyU0LA
         7FUVV4iYDTME4jCi7gWGlnARTWNo6OUiaFI+tXHGT4/jDVPzDxvsnfUn04X84ASixpgS
         UUIEQ32AfsXj3RX74TnUPRIZ3xzOOGLye4ACGXfqYagVOBzpvZa25TLTw5RiA5ny5Emo
         REyiQPtin4aTWgs5pSNmVU/+t4KApAk3KGDOUekwoae0VCHNyTbkT8ih8+1e74k83g00
         nGgryOy1Pt8PxYze/aek5s44TVTUofjii8MMZMimfPyeQk+9IqKJNUtlgc1OD+cPyBUt
         HmXQ==
X-Gm-Message-State: AOJu0YxJfoR1XGtxRccEflTMw2LgCBd8t7s8PhoLsPoJoURwcK9NO8Ci
	3pP3LeJbg1BiuQXRDs1/3oM6FcWtRCMJFFoIyjmF9uaJTsvaI79/K7XFhUmJNwasbzA=
X-Gm-Gg: ASbGncviBnos/FiRFFvKtQCTjSYPELjqRK/i+LbsU47lkINoDZr7w5y6iTsmu1+tT2H
	prjav6xUYRwytFTn2E44x5T2LjsHSfSwi41qpQMhnynxbkxFo9hxxkxBiLJHpObgX9ywl1yF6vb
	G3adZSyHTDYD2YagzB/ByZa3+PZbC2tsYczNCrm+TgcVXAy0EmuLQ+J4pRqDZDVomEHxn0+AlNB
	v8Er2K87fh6mVXB5YH1mhDRYbDaLHqVjMISofyKBsZKoNvLv1ZQ63xRGTWvPHqiL1+exF5TjB7/
	o2seK/q3ZhEsdl44BQpKFrIPplipbrHIaqZNXOZ4OGUncMBhdzwD8tNL7cX1T+9X19pGzqvpNOz
	7+tFlgeWKP2q1utMoNQ==
X-Google-Smtp-Source: AGHT+IGTS3C4MNCq+aw22xTnq01sw8nUASYU0w+f4Bsq2yNG7missxlZkISVB8+vcdsLs6QkRmv8xA==
X-Received: by 2002:a05:690c:6308:b0:711:41a5:482a with SMTP id 00721157ae682-7164d46a2d2mr64613437b3.27.1751487271759;
        Wed, 02 Jul 2025 13:14:31 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:873e:8f35:7cd8:3fe3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4347sm26124157b3.83.2025.07.02.13.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:14:31 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: [RFC PATCH v3 06/13] Docs/admin-guide/mm/damon/usage: document dests directory
Date: Wed,  2 Jul 2025 15:13:29 -0500
Message-ID: <20250702201337.5780-7-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702201337.5780-1-bijan311@gmail.com>
References: <20250702201337.5780-1-bijan311@gmail.com>
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
2.43.5

