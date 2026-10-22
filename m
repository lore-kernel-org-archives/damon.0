Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792642634;
	b=VVBaSYR3mWleJXiiGPDvjcMvI+MWUeYk2VSURHuaJ/MuS7usbf6iExi/afWjtvy2riny
	 rPmQYqfScnQNmHWDn9vNurGcLqVqdkwqKpBsRECBrdNfGXNq7XOuLMRNyjpzGeCothe1b
	 gmQeH4K0227NWzGjiwUtZ+v8gDuJu/zOJPB6hCBhMu+xtIUXe3Bx0Sp+vLt2UQts3f6w+
	 ZIRVqQMTXCOMsuhskhEquOFqCpjUbPu58NcsE8a/qc8NYZHRQlFb0gxdQ4MPw5m0nattx
	 J8XL3G+AfD4wX6fReocMUtFvsM3FvgVYLzhqTivJtSCh37yGTSroiQ988hb0h/OoZrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792642634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1Q1fp46m+qK2xLV1/Qc8OaB9RamwK6SIGSSLtC20+zk=;
	b=GI5gNDMfmTRZR0yEIFrpG8ykgJnT+FSJhCWF6144YeOwB2nyN0w2UmgiJ11GRi/iiRVT
	 jSC1pRNNMkP72jDbTfZQd0vEfclvHshhamvDHUUQ3cV1EnEGKBagLT8IM8fjpHMGia8Ji
	 w5IMmOS8Ty3pPRyVkKLqjADXzFNcL1Af0uWktf6GtoNYBzga0iAkSjAjZHuXt0mtf6uiu
	 mcSMReGUZaT5lhfkl1xLKVxNQM2CqwhoMhFQxlxHwrIxFOr4f0R4Tpen7OGhygqf2zfqQ
	 OoF5aHHHH3gBvgpRtdH4Fh75DvGYvZ899IvakYHtsS/kyjS1MGXPSbRXrtn4GyguZZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BHlBcNYG;
	arc=none smtp.remote-ip=74.125.224.133
Received: from mail-yx2-f5.google.com (mail-yx2-f5.google.com [74.125.224.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53765606A319
	for <damon@lists.linux.dev>; Thu, 22 Oct 2026 04:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53765606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BHlBcNYG
Received: by mail-yx2-f5.google.com with SMTP id 956f58d0204a3-679b519c952so493493d50.0
        for <damon@lists.linux.dev>; Wed, 21 Oct 2026 21:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792642633; x=1793247433; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Q1fp46m+qK2xLV1/Qc8OaB9RamwK6SIGSSLtC20+zk=;
        b=BHlBcNYG9B9taB9VYzPtFhyuDL4PneywVGbPuGN+b+bi4+FGpH99Vm9tVPVTaELWVU
         btd664UsFFILrEHzYiQWM2rYtoWzJp96ScA1hwKWkI58hrL1EKCltkLOZfYMZ2fa4A6h
         58ehP0xLrO0YTw85RohUwUihnmc0c7kz4NJOBcMzzVYONL4LFMsrt3mqwlUQHM83VAkF
         PyqadPWIEcG/TivD4yv105tuMHwZlUBDjjxG3qVT4da2hHk4prBj9XZeUVgxopWbdT5Y
         W0v2hSX3S65Td3+7+eEIb3YjnHTmxJqOjC4TwH5JJ9RSgNjI/YbrKnyu4D265Inxclq9
         Ufvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792642633; x=1793247433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Q1fp46m+qK2xLV1/Qc8OaB9RamwK6SIGSSLtC20+zk=;
        b=or06A5AypWRq0FbgNkI0Rsh9F11J7orCHUgHN88Be+onvjzURGhc6gbDp/S9ImQhgE
         +RftXMZ2QV4vJDrgd7pQ8BvLE3vvqHa7qTnT4ciTB+9Z46mMLlA010b7IgHjjJL5qlUK
         +fC542OiSvMC15k/CI4s9GFiMMiAD9BZ8HxNorJwO1+o6w1Zumpq6hJveEdNildNa4wo
         F4fnofMIM9DRYI/bi12pplBUkjw2HJAsX98QZkHMM/uUtgMtyKGGijDfO8L0l5WdoIl8
         YVv+S+6W003NBwVeo94g+j32QDrCj2c8OufnUkBxgD1jmTVdAwqWygbj7/zmdTdGInnQ
         ZF+g==
X-Forwarded-Encrypted: i=1; AKwUvBw0Rcc96ZPvAobinh9MDDqsWif3qFdFKzqw8wLYKQpQZCgaAk0lkCTBMrYkCE1YiP3qaaKKdA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKChNs+Eybd/+hbhVIcQOyJVFkE1yckO0EZH1vuBpj7DUpr3UNm
	22pcdogzuI0cER9BtBkd8EnlMsdDOib5f7t7xYNzAMb8JFYiHYPteh0onogX+nHX2lJY
X-Gm-Gg: AYBFou20U3gK2gpYmeGVPgIQZQdCA5G1JNIKoAajcb5YvO0gzQk3xDjOml+bnn11i4H
	HLe+5A6nolbV2L4UgeTBs/O5MSj6x64EN05/xswXzbaIKrDMimZx9yFDfXGnIVNyU2V0auAji+P
	U/3NgTbVJlGuLal302YLhVVc+9m5Mnn6nQkpNaaw9xRJNpsa8By2fKitaGJtIPsy6iZ+ZGmIoC1
	fSfUyxzPXUX1IEqAm76I/8cTGJEkGtSy8o8ujRWjDGo9rfhLcWHa0JUpSjYmuenoqtHJ0OuzG50
	vku6MqXV6TdkrJcGzy2hiCtaFH7UN5XziyxIR0JP96RuUbkbfmNMriah1i1Z+r61g+z2GWRTRoZ
	eYeIYoNdrXSBl572+WZgMbX2wmd1UmtluAjmn++2jumcqBFGulCYSmZ7FHcuYG8CiZ+Q27Y1sfG
	cPEgQPMlCXIux110a30hXEOTK74MOztHk91ObKwMCrQ4pPoavu05pG5c9hnOKkgFbi7KeimRiUG
	NKRZ+O2lMQtn3Q1hSxitvhHKLuDJ+xs0DJpgZlyU26gktbweD4MQMEdDatm5FMfllzX71toOX2E
	kmpLsHGZjqIhA//PW6vpbfk=
X-Received: by 2002:a05:690c:c511:b0:8b0:a7d5:8595 with SMTP id 00721157ae682-8b133fbf240mr21699977b3.51.1792642633190;
        Wed, 21 Oct 2026 21:17:13 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:4577:1050:cde2:63f1:eb1b:b344])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b13019e289sm21329957b3.44.2026.10.21.21.17.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 21:17:12 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org
Cc: corbet@lwn.net,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rdunlap@infradead.org,
	sashiko-bot@kernel.org,
	skhan@linuxfoundation.org,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: Re: [RFC PATCH v0] Docs/mm/damon/design: document data attributes report infra design (beyond page table accessed-bit milestone 2)
Date: Wed, 21 Oct 2026 21:17:08 -0700
Message-ID: <20261022041708.2690-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018200808.379209-1-sj@kernel.org>
References: <20261018200808.379209-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

On Sun, 18 Oct 2026 13:08:07 -0700 SJ Park <sj@kernel.org> wrote:

> Good question.  damon_report_attr() will save the register contents and pid
> into report, too.  And the probe in kdamond context will decode the instruction
> and get the memory address.  For physical address, it will also do the page
> table walk of the process of the pid.

I measured what the samples carry, to see how far decode would go.

On AMD, cpu-cycles:p is IBS Op, and its memory-op samples carry a
hardware data address.  On Intel (Granite Rapids), cycles samples carry
no data address at all; the PEBS memory events
(MEM_INST_RETIRED.ALL_LOADS/ALL_STORES) do.

Share of samples with an address inside the 2 GiB test buffer (random
loads and stores; perf record -d; one run per event):

  Xeon 6960P   cycles:p / cycles:pp / :ppp     0 %
  Xeon 6960P   mem_inst_retired.*:pp          100 %
  EPYC 9555P   cycles:p, cycles:pp, ibs_op//  ~21 % of all samples
                                              (the memory-op ones)

How often the saved AX holds the target address when AX is the base
register (perf record -d --intr-regs=AX; store to (%rax) vs
pointer-chase load mov (%rax), %rax):

  Xeon 6960P   store loop 100 %    pointer-chase loop 0 %
  EPYC 9555P   store loop   0 %    pointer-chase loop 0 %

PEBS saves registers just after the instruction retires, so a load that
overwrites its base register defeats decode.  IBS saves no general
registers (perf reports the registers at the NMI), so decode is not
reliable on AMD.  Decode in kdamond must also survive exec, munmap, exit
and pid reuse.  These are synthetic loops chosen to separate the cases;
how often real code hits the failing case is not measured.

For the physical address, taking it at sample time, while the task is
current, avoids walking a page table that may have changed by the time
kdamond runs.  IBS supplies it when valid; on Intel the producer can
call perf_prepare_sample() in the overflow NMI to do the walk.

So the suggestion is for the first report type to use the PMU-captured
address and load/store flag (AMD cpu-cycles:p; on Intel, the PEBS
memory events, which moves them into milestone 2).  Your call, of
course.

Thanks,
Ravi
