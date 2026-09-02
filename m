Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B94A92F7
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364195; cv=none; b=eCABq0EYpfB4LX2gvIZ3PuaQn9Tpt51kPbWuwKgCX3PM6ZiJXqL5eNKYY0ZJACUOmLbcClqrgRdEgwmac+1qCOCFhd47i0/X1Sou4Ov37rZ7gmX2I0LojuNwzjvesVFrUjzJMqyD9Muy1FEcmnAlUwwrHCICCwb6W7Ax0nqxGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364195; c=relaxed/simple;
	bh=ZFUyQ3mpVFiKVb7A5VcBIH1Co5Fvu1RaKkX3s7o6tGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3RdEU/h7ALODgo2IKetR4xeUoZ5HRbDndibmYO2XJp695CpXIX8wpuADVj95/6WntzYXwBz+u2uZulVmPdik2BOS9Ctedfp8/MIyDxngZlJR0a5qzW7XMFMK2U4BWZX/FV6UPDomEdwL1SS5MVv/gK81aPacHxZy+THZb7xSlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA/K/TmX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA/K/TmX"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso1220056a12.0
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788364193; x=1788968993; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z89yPC+uk4DMPmL1ApFKYR0uaTYQLE6V3binhup5tUc=;
        b=lA/K/TmXnglhTdBCA1PNDFgnDp7YhqYyb+4rJlSOS3tEiAUx1zq0gpvy1yzZOEnp8I
         eTy6OTEKjd9bCUMRPNQsXqspOpMJFSxetR5lQ/79KQvB6iXkhAIQa9PTOt6Lz0qNwJLF
         PbZskf+2NKNIldzGtKsiHp7xFLE6L7fZQ1HlAJtHuFXGGBEFQblgdoQtyOuWZQSDwhOH
         /dxdwipsF7RqEeajwyyMjpXdIrNO+HIPwA+rMDcAwtxaiCS4XOH1mxd02Ul8f9U0akRh
         kc8rij1VXEOTDbmI72DyioMKETLEdEpdyt1a9pwTdE+Ya8Ylv5oa1McH1Pg9SSa1H+uY
         rYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364193; x=1788968993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z89yPC+uk4DMPmL1ApFKYR0uaTYQLE6V3binhup5tUc=;
        b=qLrb7MO2URsQM6l8S2KXbwjxNVj6eYQvgkUNEOmrdAGTdNo6uqUCdQ/sjoLiXzTfVo
         ZiUr351c8NMfdymuqHxnz+XpeFg+SUal5H+iiWwyTK/936wSq4Yx7qSRLfJ5GN2oFYZD
         4au22OHI7v0WGM9Rqdu8Cj7/7DNppNRDzetoUUWNlbBlboka/kunI1aclVtNZjD6+enV
         VpFZfXOE1j0I61HK6sNAhFZ+aupKQK47NAtmOi7blhg3p9ajANXLGqiPC1u8y+sMAcCe
         8QsLDRCzvyR3pnE6Ri0OwgBobPTIB3iW1ca+IiJDm61MvlDzWfM9bi+e5OXOJ/RfAcIP
         nGaA==
X-Forwarded-Encrypted: i=1; AKwUvBxtQ7t4rQnUCAJz1dZ0HO6VKIJXM6KM8Qx+KsaNRUuLrK51FFUZsYxrPsQIxx32gjDqwPDisg==@lists.linux.dev
X-Gm-Message-State: AFuF++kcmoCQV28BCzbBfhumCjlEyJHhv3C4JJHWFro0ESs+hqaParyF
	h6IlSqyqV0/GyUxjJoeum1tuVs1tPLMZT4TYqRvJvndbBQRUAj+AXX5d
X-Gm-Gg: AYBFou0euG/kTH2832q//GhJ9JWvZXFI9xPJZ7w8pKKa09bLLo0NliEhl6H+dOFYoCC
	vgycm1AwDNcCI52T7XlfufI9EEDc26TQWp5hNeTBxBbbwISSsSduU/HaoEJ1hRoSH4lb071k7KB
	dHTA13ccHFodFH1vOiS99hpncM8LLZnnqyuQPX9IC6/NvDA1C5gcdRkSS1qiQjRbV7D2LPHVa8Z
	YHwmKk+jvxE/8MCg2Ei0oD+uskK9xx7Fm32W9lA+f7LhlKQaAOXY24vaFxTXRf7CjVfFPhSiO66
	ak+1Ji9R/F4qwY4jEnysyh6ZP76n5h+td5o7DWzCZZG5GTbUOSU+94kyQu7jr+9HV7notLh8LQp
	AwH9HyGEtO0Es6q86T6L7amEQBUcZyLRjbqzGOSRq9581ysVkg3+Ewy0uJGVdedXJZhGThKL2jY
	z3N6WcB/x3PU6E1AaTZcblQBsVsEC3JaG5vXM37bpbll09XImGglR3QYdxO70=
X-Received: by 2002:a17:90b:57eb:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-39aedfcc06amr9073487a91.6.1788364193126;
        Wed, 02 Sep 2026 08:49:53 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08300ba2sm81417a91.1.2026.09.02.08.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:49:52 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 09/12] mm/damon/tests/core-kunit: test damon_nr_samples_per_aggr()
Date: Wed,  2 Sep 2026 23:49:42 +0800
Message-ID: <20260902154944.4035059-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902151955.88892-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Sep 2026 08:19:54 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed,  2 Sep 2026 23:08:41 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:
> 
> > On Tue,  1 Sep 2026 22:47:42 -0700 SJ Park <sj@kernel.org> wrote:
> [...]
> > Both `sample_interval` and `aggr_interval` are zero here.  Since
> > `sample_interval` is the denominator in `damon_nr_samples_per_aggr()`,
> > would it be better to keep `aggr_interval` non-zero when testing the
> > zero `sample_interval` case?
> > 
> > This would make the test explicitly cover the divide-by-zero protection.
> > If the `aggr_interval == 0` behavior is also worth covering, perhaps it
> > could be tested separately.
> 
> Thank you for your review and question, Kunwu!
> 
> Yes, that kind of additional test case would be nice.  Please feel free to post
> a patch if you'd like to! :)  And no pressure, no rush.  I will also consider
> doing it myself if it seems you are not interested.

Thanks for the feedback, SJ!

I will prepare a small follow-up patch for this test
clarity improvement.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

> 
> 
> Thanks,
> SJ
> 
> [...]
> 

Sent using hkml (https://github.com/sjp38/hackermail)
