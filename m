Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8455937998B
	for <damon@lists.linux.dev>; Wed, 26 Aug 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739846; cv=none; b=PMp+fWkpUA3+nCqmBU7Zy3K+GF68zwPEQ6cMEEQeP2LaPwwINJ9EpUZ6vT9fTSkPsSwpGsYLjyWUk3i7vpBejxcRp6WHsj9dHobTvpdcFZXge7sFWDS+20fyvwuu5Y1OwgYjJiJJY5JU3Y7la/OMGN8GqDI3ciQrvSJ9XZU/nhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739846; c=relaxed/simple;
	bh=RUq1wR4ZMkqZ3vbE7MBsWYz5ukgX1zWXwxhMjIhQDTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZRbTlY7cPBs8+uis4JrfHbkEsBPKCFkTwrsRYZqBJIZQB4gO+sI0S3GcTCYwAXoX6XqwDSJRw2buSwuqmPbgUvb00EwOoPEsK5iLHqgelKkN2APzw/sI4IxH5MS8iZwFGg/IjH/8m0TQht6EZdJLBqNWtf3+O2r1wxi/5sD7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlMCdpH6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlMCdpH6"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3900e39d935so1167272a91.0
        for <damon@lists.linux.dev>; Wed, 26 Aug 2026 03:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787739845; x=1788344645; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pw/vnND8u4fIjmZBCSgSJHXI2o3qxjuK90n28G0R7dE=;
        b=IlMCdpH6z5Sm/uJ99YSQyZz3l9CJYhA3YFMJ4ZCptv2Yth2mzZzTCU9MoxKhf/kN7Z
         EHDNM3TODUtF1aQnQiItLc3blauHUr4+BJ18fPh0Je0y418oS0mI2fH0q2DevS4bomiz
         35OdAP9iYzhnVCf/joZde+DHkcloHTiC4ofcwulccFFfIQjqgGX39AeKEytScMBsSUqi
         AktAaNRWpYlaeborweOTMV4KVoCQgHLp2n8tJr1OW1Bpk0FZHaBXfyAuhpk6Kqh7qTp8
         VPBZ9hqhGwDVWTcPNBZrYUu0CV6u1dPASx4TwjKOj2+oW9/Gn5m+VEUDolIQadieu9zh
         JtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787739845; x=1788344645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pw/vnND8u4fIjmZBCSgSJHXI2o3qxjuK90n28G0R7dE=;
        b=qeNik57AqYpYR1CvFuOWkkHUbpuROC82lyDKbqwl2QPn6w/pn5JjZ9/gtuR3f83NNH
         r8hX+HM2bpp+fzyAs6w12r3YTDx9rqMZtNpn73VLPNoLmVnV7zVFu0wbbC0h8Y/2fGeT
         AiiyKL8Y5cYZ80oF2tNIa9DjsEl5LVB13cU0tA4UpH/ti+TCOJpfmTnPhGBwfF1Rjrs6
         rtKfu4EJQ3xcVAirz6EBAc4USEn9OUujoIV4ExSjhIb2Vj2ZFM/4lbgeHKRNTQNn1+TF
         f82xDmXAOeLQkUtn7nZDARzuyzrQMhxOI/kOuoK+ksZjidQ6TJV+PIs4VmkQt/DYwIaV
         1lJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsSLu+PnKQEWGm2YfhJHZxFsJ/s0WD+YZLCFwD7I7CcIw5lTjz2rm7FOiV9sD77cmOhQ9Zzg==@lists.linux.dev
X-Gm-Message-State: AFuF++k8QRUb7EK+KyLhcwx3p/hMYUvGo0uMRK4UGEfKxypNM/hjj/VX
	HCM1iSmDO90UcP4mR4QsTcY3o3RVH5XNmrAKZi+6d5b7t7BPjY0CIygs
X-Gm-Gg: AR+sD1286ihRCW5fnLcLr8xx/vLmVjXzEGju5DNKAMDUDCY2LlMCgKKBQdo6N8lIrsd
	Lm+heqUB5iOMcsA/FHv8A3avftH/wmTxSF40lIc71QBql0wY3/9Rb3ElNzajw11rHZy2J5gUAbw
	DcEfJSpLqIN3CRe2Xh0qbL+g2SQaZpMDr8isujsKaqcQg1IMjYchN+gzDYlnVrkGeIQKqAcTAEv
	8zstMiOO86+tpJ+IlQY9LWHAkHAqSq9i2P5H2Fke/WPUJA0PaCAbl2Jca0sjQWzlMjXVnveS4lz
	NlZXgkceoOYpxdPRdH3lfErKRugTl7DcKsKiiD87LXr+A7fa9TAG9G98By9jifTDcXJ05CNvOT3
	EyPs0OS2BIjHUucHxJnGqrqRqoymODg7EEvQ2c1eKM2gHlLmWUtPv6VreCdTtU27UtJRMjuOJ4C
	pwEprGZdiRYdcUVYubwxjnMxgIGC9bITYx4FRBPpCNmBCVWKC2uiw2Kf76Y766SfNy
X-Received: by 2002:a17:90a:c107:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-3966d412aa5mr12550916a91.7.1787739844634;
        Wed, 26 Aug 2026 03:24:04 -0700 (PDT)
Received: from celestia ([2402:1980:c23:7fa2:94a9:2164:3642:a5a8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905c18bsm7535836c88.14.2026.08.26.03.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:24:04 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: fix damos quota walk-position tracking
Date: Wed, 26 Aug 2026 18:24:13 +0800
Message-ID: <20260826102413.8466-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825135458.64555-1-sj@kernel.org>
References: <20260825135458.64555-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 06:54:57 -0700 SJ Park <sj@kernel.org> wrote:

> On Tue, 25 Aug 2026 20:46:16 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > DAMOS uses charge_target_from/charge_addr_from to remember how far a
> > quota-limited walk has progressed.  The current implementation has two
> > problems:
> > 
> > 1. Once set, the cursor unconditionally skips and resets at the last
> >    region of the tracked target, so the last region can be skipped even
> >    when it has not been processed.
> 
> I don't fully understand this.  Could you please clarify more?  Maybe adding a
> realistic example scenario would be helpful.
> 

Problem: Unconditional skip of the last region

In the current damos_skip_charged_region(), there is this logic:

    if (r == damon_last_region(t)) {
        quota->charge_target_from = NULL;
        quota->charge_addr_from = 0;
        return true; /* Skip */
    }

Scenario:
1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).

2. Quota is configured to process only 50 bytes per window.

3. Window 1: Processes R1 (0-50).  Quota is full.  Cursor is saved at
   (Target, 50).

4. Window 2: Skips R1 (0-50).  Processes R1 (50-100).  Quota is full.
   Cursor is saved at (Target, 100), which is exactly the start of R2.

5. Window 3: The loop reaches R2.  Because R2 is damon_last_region(t),
   the old code unconditionally returns true, skipping R2 entirely and
   resetting the cursor.

Result: R2 is permanently skipped even though it has never been
processed.

To fix this, the patch advances the cursor every time a region is
walked, regardless of whether it is applied or filtered out.  This
allows DAMON to accurately track whether the last region has already
been visited, eliminating the need for the unconditional reset.

> > 
> > 2. The cursor only advances when the quota becomes full.  Regions that
> >    are filtered out do not move the cursor, and the scheme can remain
> >    stuck on the same regions.
> 
> I don't fully understand this, either.  Could you pleae clarify more?
> 

Problem 2 is a false positive.  As long as the quota is not full, DAMON
will continue iterating to find applicable regions.  I mistakenly
assumed in the commit message that encountering filtered-out or invalid
regions would cause the cursor to stall.

This patch ensures that every target is traversed sequentially and
deterministically, even when the quota is set very low.  I omitted this
benefit in the initial problem description.  If you think it is okay, I
will add it in the next revision.

Best regards,
Rui Yan
