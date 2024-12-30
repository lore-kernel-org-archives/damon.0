Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB177FBA2
	for <damon@lists.linux.dev>; Mon, 30 Dec 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735566174; cv=none; b=XgOp/NcJ2gIZaPqkb1I8YfaITIhpZ1K4KLdJ2ve7Zw57VreFdgklWp6cWcMIbAj32FUzo6PKahaNBKsxRUL7caFh+DTQkSVMseV1N4S+SFjq1wuZGJFSGzac5XG+nmc26CMp62hAzt8OPr5ki+Zja7x8lWEhI31ghm1OMoXRm2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735566174; c=relaxed/simple;
	bh=JeUgFHiUXtnV7+84Gg7G/8oxklR1dqwJ6NRuGammoVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dms5jc+tpYwXYqY/FAzEO/WMbVjW1cpf3VPY7L0K8c5MdjMKYLXvB3sa/HOssiaDl+qDJ0pSOW+tF8c1XCS9pTT8YTt0FcGQeb9lJhp0126q1qu1NONouCDvgif711h/4hYS4rTz7XNwjrAYul6ZNZdvDQsMbRB0ifUeDBhwlAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYuLZ+g5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYuLZ+g5"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2efded08c79so9410694a91.0
        for <damon@lists.linux.dev>; Mon, 30 Dec 2024 05:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735566172; x=1736170972; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dvwr0VHbSmzkrhe6RRd4Ts3n9f6nClyHsHNalucMvEs=;
        b=lYuLZ+g5giqa9RfaIahFYzKSNKR+siXjrlGEQUIGSJH/HAPyQFCJD357kB+HB28A6Z
         QWuQodtHbdSivdgOWKzmUeU5+n8rhtiYjV6mtkjVsFrqvoeypOJJXsGFeNEhls+Um06O
         WzbeZEsaht8CbLRfeUlPufE6mWWGz4EZrHDArZuMoeENyLuzwV0J7ZK+TZbp/gH72u4H
         9+cswhJRWXTgDvlkzLs6RiVagjJ5uHsOcN8JN8pSNAGjp5fx/7VSvzVkAnSZ9f8B7vKI
         7FrRKzopqo8w0wC71z3l2+ss1sngw3VAJKXsHr05Ql1+cAMb10JjwqBXuosDkBzq0zGJ
         GcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735566172; x=1736170972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dvwr0VHbSmzkrhe6RRd4Ts3n9f6nClyHsHNalucMvEs=;
        b=Budd6wfoM6v4iFc5Jw1vxKtVFjRhv7xvD+c01zTggSO89shEYnqLdwDsgywFps+/BK
         1i+zdWrG6EE7RDH8XBbqOec2i7SCWdL1j0hmpkW7dCWau7+ytIhlN1T5OnIGnuYxdJCP
         BEPzYn6HyvK7wNDuANKXUZFoaFHLWTqqG0AA24OhHjsj1SKvSLWFviqsjhXmsFE7C53F
         8BN1HRNwA85mEHJ/hpgOS3WjTAa4FnyxGuNklbkv8Y6chD/Kbc7qpBfnk37XoRZ+/DEc
         WvloNsPYc7BRfBmIc2jBPFfEV5eUGHeL2Sb0ZtwtsHwG+oA61WwfdhRZUAIzqdiOk7LR
         c91w==
X-Gm-Message-State: AOJu0YxXsTASQHVXCEv2rp89fWeNl13dtXjm/dyXUJlfljHTkzVFNta7
	9CLihJJC9CXDZ3k311HMKV7DDzfqvz02ePYtCI5dZg79e8gtVdr6tnKJPQ==
X-Gm-Gg: ASbGncuttgjmXDWpACF4Ai2mpAxsDN+g/2i9CiIQ0ew/otO9N8ldt1SJEzEg9pR36Za
	/n5RsHzDo7B+js9usjTvGTIiFHri7oVTxKrm6wzRKKh2DDkibuvWb0CzPtoAL2eIhB1ltoSrV3B
	lsnJdbNDVRoM69iOgM1U2o43V5i1ZjEDGSNyyI5/Ju046w0CAKSP98b94zRD7PUnFkrZWFkItEz
	UkSM4OWdktHrWPdZy5AXEm6FQODA7DP6jE5Keoy7+coJ6LMbWT69t1+yPYjpxJBuzlWzZQ=
X-Google-Smtp-Source: AGHT+IEhH/inNL2JBLrz3YaKPu6iIyUocDxwITyVSnRZAw1/PbyauOurkICN9LEyIhgqQ+g/fRtzfA==
X-Received: by 2002:a17:90b:3d44:b0:2ee:e518:c1d8 with SMTP id 98e67ed59e1d1-2f452eb3268mr56276510a91.30.1735566172031;
        Mon, 30 Dec 2024 05:42:52 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:a5f2:adb7:9db5:d648])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f454f58087sm20971153a91.11.2024.12.30.05.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 05:42:51 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	akinobu.mita@gmail.com,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/damon: trace: print address range in hex
Date: Mon, 30 Dec 2024 22:42:20 +0900
Message-Id: <20241230134221.166041-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the address ranges are displayed in decimal format in
tracepoints for DAMON, but hexadecimal format is easier to compare with
address ranges in /proc/<pid>/numa_maps.

Existing tools such as damo need to be able to handle changing the format
of address ranges, so display address ranges in hexadecimal with a "0x"
prefix.

Cc: SeongJae Park <sj@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 include/trace/events/damon.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index da4bd9fd1162..8df59ef18660 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -41,7 +41,7 @@ TRACE_EVENT_CONDITION(damos_before_apply,
 		__entry->nr_regions = nr_regions;
 	),
 
-	TP_printk("ctx_idx=%u scheme_idx=%u target_idx=%lu nr_regions=%u %lu-%lu: %u %u",
+	TP_printk("ctx_idx=%u scheme_idx=%u target_idx=%lu nr_regions=%u 0x%lx-0x%lx: %u %u",
 			__entry->context_idx, __entry->scheme_idx,
 			__entry->target_idx, __entry->nr_regions,
 			__entry->start, __entry->end,
@@ -73,7 +73,7 @@ TRACE_EVENT(damon_aggregated,
 		__entry->age = r->age;
 	),
 
-	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u",
+	TP_printk("target_id=%lu nr_regions=%u 0x%lx-0x%lx: %u %u",
 			__entry->target_id, __entry->nr_regions,
 			__entry->start, __entry->end,
 			__entry->nr_accesses, __entry->age)
-- 
2.34.1

