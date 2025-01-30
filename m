Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC6D2FB
	for <damon@lists.linux.dev>; Thu, 30 Jan 2025 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738203327; cv=none; b=bKPAK2Yoeuml4hX19bp1T30KbdUzGzsagMOB8XESQNMOLacqiIqhXERbxiJf9MGYoTWRFH+oEdg/zaPL59ZDkPz3qE8FuaOdqnA7H4MIw3J4QNPoqYHURHd0YGWRgoGJoLvY4tZ3SGrVGNJbltohVHCYoFXErWt+UyrCTsJ/atc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738203327; c=relaxed/simple;
	bh=orZla9O2A+E4DJv6OiX5psoqxdTYbHyT5BwavlcaGG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMapkwyE0hsZWeR9kaaQJd8P1jbYhDZl/5ditPY4d2JvF5KAV9k6LiEpilAb6FaWdCRxzVomFgYwlTpQXYNaPVoRMtFYLtov3lkiyi7zz8xaEkWcbqc77vV6TSFSb4c7FsnKFNfmMhYBufpZDgpAp31ScBD8oKUxiQVRqAtvdiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ucIawlwg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ucIawlwg"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-219f6ca9a81so35625ad.1
        for <damon@lists.linux.dev>; Wed, 29 Jan 2025 18:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738203325; x=1738808125; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL2bVoQzvTlTDBwGlrT2Hn0lIShKB5FFgTt+rq/GXUE=;
        b=ucIawlwg1Tq21hTnoP+MNzysRGcJl5ioCaI2r6xjUN/I/jBhGt83uB42ZNJB9XXuIc
         +cOYy2UbT7zEbo7d3ovWIDhD+FncfqtdvDx6rUUlAKudbxCwsG1aGG1gdvn9PBTJ013x
         DNCseL0qlBorbMrlu8S2SCILxOqw8acK5ecY64i41eQdKguCi7FIyVGkp2UlNMB9w2uV
         19w5tcF77Ui6Zu8sdEKVTkjoBkpmNfn3Bb2mrIK3xGhPzsWkirJfW246CKbdKrsxr6bo
         Ki16sUM/8dZxfwXvjiHWhkjx/6UyA4gJz/WQXGA8fU6EiDinf4p7hN/8PV7Zh++IiV7S
         21Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738203325; x=1738808125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zL2bVoQzvTlTDBwGlrT2Hn0lIShKB5FFgTt+rq/GXUE=;
        b=CearfOHi5Pl1gkTazNJJ1xVPrsNgOx+rX9zZafl5orGFpLSgiPDivWiNQAGOAYe5of
         OCTSINsW1tF0Tq4ngZyjenWO8nXXDGr1IubgTHv3mUQJYKldbxzoVPr8J/0F4bUfpPNn
         IF+SbHRYfjtr0/z0EW06lZVL9PSC+gK8Q9VGZN6UItTG6LepmcYmE1labkKysLT5LD5C
         4H01Es1o28TlnQ/ika04cFNVNj4Jpr4W1Ov4heiSN0FknTHqt12MCv4+h+itm3gLiECr
         Fe41taiClS2KoCWrisGHt6WGDy8pWC9VPRo9Nr0PsOzuDqEndW1nYOmor43IcvERvOJA
         d6ig==
X-Forwarded-Encrypted: i=1; AJvYcCWGQljV7z3uX5i6ZcPDqCXBN5gPBk+wGCypRzKcjzNZpzP0KwzftIAh9HFH8TenqL2CmFRJ6g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy3KAIFpW9hVAdRHL7IixuPNcugKdu6K1BQH7USMABSBYtjSOj
	V7UF3Iw2m35uaoMkPEeeQ0VoJ8udQjAlcJoLBDQt4z60guFqe1oj/3mBrRudtKLogw/Uke5SN4M
	kG0qfL+IZmtda2JhXTYg4C1qyG2DqcAcuIy2w
X-Gm-Gg: ASbGncslFXaPunvpaszG3HB03Ombz3hNcFWRExybT/Asy8SpsG2C5vOJO1YumWyQ0yH
	O8bfOI+qnxSMQywmFsVPTu/Ufu2BjQtmKViKyxUkHkRMjnNaTOVFum5MDcYpcv6B9CA0WFKQ7kO
	JmZkew+EUmME9k6+VADiIpMeBi8Q==
X-Google-Smtp-Source: AGHT+IHiw/l5Uly3TxfT60Bv+QsNpJ//IE32/Ma11U6wfwDQu474zQr3xgWxbyPKTz1IoSdCOksR8RL+mMMOIfQlrUY=
X-Received: by 2002:a17:902:6b01:b0:215:7ced:9d67 with SMTP id
 d9443c01a7336-21de2479655mr1342275ad.24.1738203324959; Wed, 29 Jan 2025
 18:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250101222039.74565-1-sj@kernel.org> <Z4XUoWlU-UgRik18@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z4XUoWlU-UgRik18@gourry-fedora-PF4VCD3F>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 29 Jan 2025 18:15:08 -0800
X-Gm-Features: AWEUYZmwbhWtFQt8BXt48jdRBHbwVMypC1AoImNfsGOiL3MKq8A1xAi_a-yZ7Ek
Message-ID: <CAJj2-QF1y1XNRYy9sT5c5=pi20+67Duf9B2Amatnu01HLmw06Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of Future
To: Gregory Price <gourry@gourry.net>
Cc: SeongJae Park <sj@kernel.org>, lsf-pc@lists.linux-foundation.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Raghavendra K T <raghavendra.kt@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>, Jiaming Yan <jiamingy@amazon.com>, 
	Honggyu Kim <honggyu.kim@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 7:06=E2=80=AFPM Gregory Price <gourry@gourry.net> w=
rote:
> 5) Scarce resources
>
>    We need to be careful not to consume excessive amounts of resources
>    in an attempt to track all these identifying mechanisms.  Even 1 byte
>    per folio is 256MB on a 1TB machine.  This gets out of hand quick.
>
>    With task-work, I was able to add no additional resource consumption,
>    but deferring to a fully async scenario and needing to track things
>    like last-accessing CPU, timestamps, and etc.
>
>    We'll need to examine this closely if we decide to aggregate either
>    of these mechanisms.
My concern with physical address space monitoring is fragmentation. I
ran some numbers on a few prod machines. Grouping by regions with the
same memcg and ignoring any unmapped memory to be generous, machines
with higher utilization can have a region/total pages ratio of ~40%,
and even those with lower utilization (<50%) can also reach 20%.
Accurately tracking these regions would require quite the region
metadata, on the order of GBs.
