Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10DF1A3BD8
	for <damon@lists.linux.dev>; Mon, 30 Dec 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735566176; cv=none; b=c7pEKIuwHHULJda50tWrT5rLCS3kEWLoISH73JM5ttJQ9+2igOXKT5Ipmd2wqrS+a0Qo8Xd+TDKoZ/+PsOBy02W/zpa+T07swTiT0gY1rRDBlHqAlzaKHOeABT2IcyJzELRYIo/F5hJK29G2QepFwA3H4rxYIfQoxAyTS+aDeeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735566176; c=relaxed/simple;
	bh=OfcPDsR4uRZ4rNeEx58jh9uYPfRmUcQPW4e2KB6aHDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7XqwnkdyK78NSQNsCSWlSj5MflhmmRB2KuhrsS2Jai0oqXYLgmn0TZkfnnWYgkecRNfQjKhGbwp9QNWqBTlRKTEMSGZ9L4NMNyFqNAi52rvWHBWgzQE+kKf7JGYa3+eKVS6bODP074RUzyNFvKdEEbi3Lg82U1ccB9yIE1z/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRL5tVuS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRL5tVuS"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso9398721a91.3
        for <damon@lists.linux.dev>; Mon, 30 Dec 2024 05:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735566174; x=1736170974; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AYjejH1cNhYWmeJ3P7XOArIbIsOoO1gSnjQCv0Tmdo=;
        b=NRL5tVuSg8T/1YgJmZGZewr0XY2hoJExukjm/qBzIKnKUML2MMxrXNasB19Q7kNq0s
         +dsQ4p2PPzrdopEQG4cyZLREcWGAHbKsbiOb1n92Pt/OF2WpGiI2VTMH+xaga11yLjsL
         ZPToTa2BZsvmh9V2LuDKJzuVlJZnqVS2dYcbT4KigZRoD6rU/246cwO6N92A+I0U9Pm9
         Stcwm4Yib0Vz5LKzJv8OyAeWImvJo46LC/IYfkxG7wawuUSx0IY8vOHCwV92yaiykHH2
         1UK5UnAxvZocAmZRn9L0KLZQkfVK2bKE+l/d5x0ho9ig4D8QSPkXMvseo50NKnMaO3wO
         GEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735566174; x=1736170974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AYjejH1cNhYWmeJ3P7XOArIbIsOoO1gSnjQCv0Tmdo=;
        b=oO460nYe5JjmGvkCqbFrfCRVl7MhQVO+LPd64DcdH2tfZ74kBP2ampos1Qto1B2VfF
         75TNsKTUxRt6mvwLROjrytzC+yuI7w5cHr1zi71XkFNcbdmDoXhUwtg4sseeq2IR+zBA
         UKozhZTClN0NOCrGUdd2zONo0+RL7nczjSt8rDROGw2xPDL/shaKXGBSZepCsTdCoSKE
         AbbQxHVeFjN+pwolHNNMYPHNdpUwS2m6wQx+D3Js2q9XFpIK5pUmeY5sLfHTimfpnJUd
         HHhy2+zA9UNVp3wo9ubdl6SxDpbleit7j28TXuejlajdwtvHUTb+zyS3cKNS9DwtUQzU
         JU/w==
X-Gm-Message-State: AOJu0YwkhoVCi/Rp6dcVPNMWbQrMTbKucZ7IlPBFsygFgk1ZLU9JJb1X
	8fdOJ9oHrduA/Eb1VorW8pD2wOpjf0iMlGff6HMJKei2MkkFp4H8xCcTYA==
X-Gm-Gg: ASbGncumC2whPhaffEdHERI1n/GRW4y6+VjnS2iJuVgKQsL19GdGKvPI138weWN7/c3
	ZyXnwHatBTSjhrNly6n9HZMQUCgmMX5+GOSuopTe+XEU8wdQlTILEQSP91G2cTfQxGvP3fNbovr
	i4zJB7nrHL8+0aUIFLYD+V8mBAks9W+Aj94wMJkRWGCeAyl3/dIeSPyZ2DyagSpPb00GDgYSLCX
	2YI9xbXQkx0TLcg/f9jwq5cwIddpwOXvwVt0ULibI8zG3RKu5aegyyw/xEx+oYAAifvYC8=
X-Google-Smtp-Source: AGHT+IGpsM48dDq0ct5WB9kz87cb6qWzqcyH8M17twLjNPvHKebAiEEIkdoKszI5zrTDQ+E1gTTQZA==
X-Received: by 2002:a17:90b:2b87:b0:2ee:f076:20fa with SMTP id 98e67ed59e1d1-2f452eb11f0mr50308320a91.25.1735566173907;
        Mon, 30 Dec 2024 05:42:53 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:a5f2:adb7:9db5:d648])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f454f58087sm20971153a91.11.2024.12.30.05.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 05:42:53 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	akinobu.mita@gmail.com,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH damo] _damo_records: support address range in hex format
Date: Mon, 30 Dec 2024 22:42:21 +0900
Message-Id: <20241230134221.166041-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230134221.166041-1-akinobu.mita@gmail.com>
References: <20241230134221.166041-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for changing the display format of address ranges in
tracepoints for DAMON, if the start and end addresses of an address range
have a "0x" prefix, convert them as hexadecimal numbers.

Cc: SeongJae Park <sj@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 src/_damo_records.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/_damo_records.py b/src/_damo_records.py
index 6e541a0..55d864c 100644
--- a/src/_damo_records.py
+++ b/src/_damo_records.py
@@ -251,7 +251,7 @@ def parse_damon_aggregated_perf_script_fields(fields):
     target_id = int(fields[5].split('=')[1])
     nr_regions = int(fields[6].split('=')[1])
 
-    start_addr, end_addr = [int(x) for x in fields[7][:-1].split('-')]
+    start_addr, end_addr = [int(x, 0) for x in fields[7][:-1].split('-')]
     nr_accesses = int(fields[8])
     if len(fields) == 10:
         age = int(fields[9])
@@ -288,7 +288,7 @@ def parse_damos_before_apply_perf_script_fields(fields):
     target_id = int(fields[7].split('=')[1])
     nr_regions = int(fields[8].split('=')[1])
 
-    start_addr, end_addr = [int(x) for x in fields[9][:-1].split('-')]
+    start_addr, end_addr = [int(x, 0) for x in fields[9][:-1].split('-')]
     nr_accesses = int(fields[10])
     age = int(fields[11])
     region = _damon.DamonRegion(start_addr, end_addr, nr_accesses,
-- 
2.34.1

