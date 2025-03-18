Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B71183098
	for <damon@lists.linux.dev>; Tue, 18 Mar 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322637; cv=none; b=qMZYqfU9lue5dNmAlMQZnnXxyXVMkXAzMzjt1yrpHEYgvrOZm6j5jVg5htaDg6i/u32Br9b7Jc4fvSW1yF2eWe+F3oKv5UrHTGMchMEI8viiysBCrbntWZ+qeBxZxyJ/VJ/TbfyFnSv8y25JA15NVkD8TplSwW1jlgbfUUODOfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322637; c=relaxed/simple;
	bh=jtPd6L3WPVafuKL/M/pP21GaWG+ZlzZExDbdGNjwH0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z84yDKT5jbFVwrFXgW200cOhIeJHowIybk+jXU/tAIvId2AgRRDz3gNETe41gS+RBduWD6WiithwuxhNBLQEsEsCjnX2pU1UuKlGA8epn0fKcZurRl617USQROH/pU779mNFA21fkjcBdgIvbZUAM0ecPo894VMLR8HaJrlxat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn3z2E8D; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn3z2E8D"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6f679788fd1so44715507b3.2
        for <damon@lists.linux.dev>; Tue, 18 Mar 2025 11:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742322631; x=1742927431; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7dHZIJ+1QQf0s+w5mDsBJ5Q7CgPW+8y1ul/VglaOsY=;
        b=Jn3z2E8DGz4B9GoFOqeFc4zNzdEqNY9fCv4mFgoXnAW/XnFOdLSqmNyEysbrPSz5P/
         hWiwf4UjwYJTKkonZrylwGOoZr5YzVfUhloazcbAFLfsOq1SC6oMik5MBCeDD9/Z461y
         L4ZCOHk6O9Hsc4boe+DVe3Kb5ccCJbi3b4kE5NWP3FWLk3Cg8Bjxaljcr5FzL6sVyCOW
         aKVjJddEnrvPBR9FczYXtDjfgOHtOrUEqJsTCFmHVl1gUPOqLamTI3yvPs3S1ZwBZvx4
         i45GE3KqL3/PvFGfwmXEjurjBLDT4nfovg5opI1LBXW1/t6m8kiwQXWBw/mnXvOjEE3F
         2YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322631; x=1742927431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7dHZIJ+1QQf0s+w5mDsBJ5Q7CgPW+8y1ul/VglaOsY=;
        b=F9EEydkzELPYh7v8o4LAkDaLFh+dPYjwVXbKktPi82PpWQA4JYh3BWJ04uz/TlV9CZ
         2MxtqzpPkie0eYgjsQPWFUNRFsiIuCoVd+p7z9NWYG/EZYJ+ORFeJpM7+AoSQ7demqB5
         u+At7zr/hWYUA/4Q1gHHux1aEn3tHrF+jUulMlJGej964H0jZaEmetNlWO+dSP/tA8FH
         HJwDVu2P0B9qCTDHrj2weor32+FTDO9xubR6VoB7Yj5KhyF+7WSn1g+FzDXn2AjBuG8R
         PwoUQRjfPjlhvlD2VnkHYkeJgFpSNGL0zKN8GZR8MrQFPSsX9o/Tpgamxf64wzbaXah+
         H5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6gZsh5arsVmHjQWMqLKtef8NA1WfIX2C/gQoWJCk0Q1ye6q8op3UWCoc3wTaLzeHR+ar6iA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxy029Mt+V7p14XHdt9PKc9KwXjOacohb5RRjI3ev5YHtzwtM06
	x0JkQBo2FPq3+5gOAGLP9jesQlghU74jXmw3wQEgACfIOEEYszG9
X-Gm-Gg: ASbGncuYvqOp1DnMx8pgjxmWO8w5LClVmaR6MTghA4T3Wf1zsho9qHax/e7HMED5jqH
	u6AGgiVYOasDs8L7BPMGFKdfOQKScp5fgE6zid8yvLehCvTUEXEVBn6YR/uxXzQCwFsy2m1bW9o
	uaDmVE16UJf+hEwesnKYnyVle4PbIFEeeWL5rDNGLohIqpUZ84r+zEpb1JP0HnCTDAQ1i3o50hr
	tiOlLo4KrpVufbPmlxniylPmZilvBVjaDgI6t4oZQ+aGCoucMGcVAxPBNWhRes5dWfrC9D3Ile/
	dvT0wj/p6jU1hQKQoQtYz1NAzPh+C5Sh+zUZYj2jMB+RoYM=
X-Google-Smtp-Source: AGHT+IHzVcio/RehLS+OJa+pt9OmpDqftnHs1DTMVg69hwSaI3nwUmwUTpUpvJoIntd97Ze/CrCzjg==
X-Received: by 2002:a05:690c:3613:b0:6f9:a8e7:430 with SMTP id 00721157ae682-6ff45e687aemr204575987b3.4.1742322631486;
        Tue, 18 Mar 2025 11:30:31 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32c80f2esm27165887b3.90.2025.03.18.11.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:30:31 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: sj@kernel.org,
	corbet@lwn.net,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH 2/2] Docs/mm/damon/design: document active DAMOS filter type
Date: Tue, 18 Mar 2025 11:30:29 -0700
Message-ID: <20250318183029.2062917-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318183029.2062917-1-nphamcs@gmail.com>
References: <20250318183029.2062917-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document availability and meaning of "active" DAMOS filter type on
design document.  Since introduction of the type requires no additional
user ABI, usage and ABI document need no update.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aae3a691ee69..f12d33749329 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -656,6 +656,8 @@ Below ``type`` of filters are currently supported.
 - Operations layer handled, supported by only ``paddr`` operations set.
     - anon
         - Applied to pages that containing data that not stored in files.
+    - active
+        - Applied to active pages.
     - memcg
         - Applied to pages that belonging to a given cgroup.
     - young
-- 
2.47.1

