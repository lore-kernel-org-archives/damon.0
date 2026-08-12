Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2854248C5
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531201; cv=none; b=Dg3ttk20U4NjV9oOn2lruHNoC5pTcFOH48scmxjmF4vgARm/l1e4IHtHSgAgN84VTIxNgpL4jxDtQAPDmQ39bAtAskZUysI1WbtNc5OIEQhHecwMBDT24DljSWkJ66em/vgjWypl+MuOaKcBqzA14Va3mUjfUKIpUVC0DkJpn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531201; c=relaxed/simple;
	bh=w9hf6IY23Ggm7HeC4zUFI1dGoXifCTC/f46vQjCnccc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQX+Wg4WolSsG/kpOgi3UUnNJicop+Mxy6L7fH0k9FtEPrb9jhbc+Pqr0JZtYNpdhE8+DsIWpJVaYj7fQ1O870aPMlKmTqxEAeOEdc7G1E371KFwHpyV7/YLj3BITaJacso8sjUsZyagu21+FghTdnzzOVPafwQhuuqvnooBD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEXgNigf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEXgNigf"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca88130e09aso482622a12.3
        for <damon@lists.linux.dev>; Wed, 12 Aug 2026 03:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786531199; x=1787135999; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f/zbV338bs86RCvE0uOChgTAyhcecT4O06NPuUtGzAI=;
        b=dEXgNigfN5qB+WPuVPGi+mVITBaPGLwjHwJOU9Dg4Gu4klThOIp8ozpSMUGbdi+ylc
         Ex74QymSiEMvKCTKC90XLEtnjo+xmx9tsZviVQtT3YvUyH7VvSY+YzCUnwfM+m7KXodz
         eiEAxdISugj8GTZRQyeFkwCYtUeoroG2mqb90KbcbCHlJe0JWudonwMglA9A9J0yAZhW
         9pWaOHiMvfXkFN5LrswXEDVoB2AkhC+Ih9dqq6Cejo5sScYuarNrzTQMkwJf3evDbX4k
         E8Bh/nUyUX+ne67kG0WnFk3m6QrARVExCN1WmN9XNN8hDleY0HLE2WI4qHdfBLk4QT+3
         dFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786531199; x=1787135999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/zbV338bs86RCvE0uOChgTAyhcecT4O06NPuUtGzAI=;
        b=kDENsj8v4Y0uJ0y+61vlMxjJeX6rC+heW5XAQwa4jkWdLDPEepM07Aavql35SlUDmD
         z08dYw8OVjMCqVq2YUv0a/cxqC+ccycfK88yu4SDSun3Z+7PPUfXWy/0spHJCygcXY8H
         P9UFz3WvXZcGymk4B2MDNPWV6gI86q5mRSo955tTQrTo2u1Kv2Y7uCf306B+/29NwmPR
         ZaWh9ymgNh8vVeFSyIkfwpXIdvWHq6FIRuG/kPOZZ7viQUOABkf0lNJjlqfPl3PgH1J9
         0H6oZFu/rRxW770/2V9VAKUcwmOYUJkSgaY2bN4f2a/JM2n3Gd/MvZFDmoEMq4cjXZsv
         KTzQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpc2nw1q+wYFg6IhE2we3MVZm0lUeflO2WKSF3YLqnH2IMNSO9HBKvHLDhBj3BGtvKAt0/VlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YysSCe9VO3D1e/W+cprkj+v+D+keA11r3AWzTAO/w/GBYCkbsfr
	li0OGtDQdK44Dj4qQZAlildyXXkZT1Pv71cFZjRR0kAkILnvn3Cnt57C
X-Gm-Gg: AR+sD10j2KZpBurDkEisWIIs+Y60H6GSV8LYJNVS0DSS+YYvtlmcxcdcaHzzHQvSZBj
	Y3tu+goJHovw5WrRxzXFRtx35WzyXQERybDrDPJrfU0RAmWA7gWdIhOHD7JyFRV0v4Zr8RB8dSU
	TjiaO2fYQ0YetvQ+Xd7I+QUe0o+XZmrfpE6tMQK96i0gvrb92alP7k1tRMUE6nAwkMEQadC9B2X
	hOcIxJXUGgsDhIi8U+kNL50TL1iSOOxALKuvQ6vqFea6R2rtyOPqGVi18dpeQw9PqJtv3xk9dNI
	P1aviptMsQet/S+HHNdRJf9/O8laoe29c8cLL3D7GV0RD+d1TCcyHgLTitvKsMezFWNuACgUi4g
	TkQmtSo8UxO7fcuEFyhAJuwAWk5VEG5k9b2cJNcN6mwkCXXok9H6RBZQqstM99WL2Qm52c6F1yj
	4czN5j5nAOopu2KYNDs8B06Mn6s24nnG+IRQqvD88xwAB2IAAFeIvTwt71CRjHPM7bqd/xgF6s+
	yJI1nsXiacgVIs=
X-Received: by 2002:a05:6a21:9cc8:b0:3c3:875d:704d with SMTP id adf61e73a8af0-3cc3f774c67mr4263074637.25.1786531198591;
        Wed, 12 Aug 2026 03:39:58 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf3d0b432sm9931990eec.8.2026.08.12.03.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:39:58 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v2 0/3] docs/mm/damon/design: add explanation of nr_snapshots
Date: Wed, 12 Aug 2026 18:39:59 +0800
Message-ID: <20260812104002.15225-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explanation of nr_snapshots to avoid misunderstandings.

Changes from v1:
- v1: https://lore.kernel.org/damon/20260811101841.804596-1-aethernet65535@gmail.com
- Patch 1 word order adjustment: Repositioned "completely" ("tried to be
  completely applied" -> "completely tried to be applied").
- Patch 2: Use two spaces between sentences.
- Patch 3: Add the "Reviewed-by:" of SJ, because he added this in v1.
- Patch 3: Make some minor modifications, Patch 3 can be applied after
  Patch 2.

Liew Rui Yan (3):
  docs/mm/damon/design: accurate semantics of nr_snapshots
  docs/mm/damon/design: difference between watermarks and nr_snapshots
  docs/mm/damon/design: fix typo of max_nr_snapshots

 Documentation/mm/damon/design.rst | 7 ++++---
 include/linux/damon.h             | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.55.0

