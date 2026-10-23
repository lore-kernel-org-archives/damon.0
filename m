Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784931;
	b=ujvR7vHAc3vT2tasj37H+hHBrgYZ+rUy1bd4EMfoVg34lQDZqseUwwvpBMuTY3NZjx1+
	 nq5vB4c94sodyMwEPhxuF55yNC0tM73O8bhbA7PGjO5VRV2rAHXzVbeiKKvJRxmPq1RXQ
	 Kf6iEFQQ1Bf9w3OYeQOBXBTX5seFQLB07AaRNT5nzrpOllfopNzw9UvVmDykmKaAzqBo9
	 VFtlA7LRcvbi8deKPj/sCzBnPuTZm1QmS9PyS8aX7BGamhmVa0mS75LHiKyyMgpfcnh1C
	 kOAr8071+WNyU7OqpKXsnng3RH61XuUBQW1MDkOI9pcl6e5H2Bq8M+cnPHT1/iXYO0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jcX7+w+8vvOIu+l1j/b12ERTdZM/yIWf3ikT9C1KkwE=;
	b=1bTUJpm4BfFfDOH4efr7m/FjS4IlRNNk35Qc03IFHhdU+LYkuHH5r6Wo9fP3sHV2mPrJ
	 h7Wvr66VDnXERoEkq3Vq1edvQFApDKN3FpEtq4972wLrQWl+mCMSDwcPENasiaitaQm83
	 SOQZI3dOBywCMAiJQckkxT5bZIBvwZ+eLupBuuoBHzRjC99BDELl+1GThYPgINrDNGp7z
	 VWpILXGUMARr0B/CMI3IBOijEcxwZWKNtknlqClUsIOaGjK0mAVP0amsYYbjPvYcouLPM
	 0L+k35NW7Mb5Ww4mREOfxKrHofVX17xlU6qjiwJzGJnwNepJVQipKfsgPD3/M1k+yFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XrMGxxgf;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379F606A31A
	for <damon@lists.linux.dev>; Fri, 23 Oct 2026 19:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7379F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XrMGxxgf
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso1210225eec.0
        for <damon@lists.linux.dev>; Fri, 23 Oct 2026 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792784930; x=1793389730; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jcX7+w+8vvOIu+l1j/b12ERTdZM/yIWf3ikT9C1KkwE=;
        b=XrMGxxgfVUoASsEs6wRDPzxiWSUPmdPH8JsVRts0nHjohhz0ukHzInavCrxTRMmQAj
         yXM6pT+mx+C6K1lRCFF44Fvbgs7dTldn4otkigDZicMiWCavNkXh9w5wKj+bnudcF+f2
         K9n2jipxMRhPBOJTXnciUKukzGDiNNC72zVfE1Jb1Gbuwxo6Uvd36SO15tHH9nDRpOvp
         /cVvRpK0CQBsEDtDhF9Jh0VPQQy6PpGHOlAGuuck8P/hRkWP9DOALAOasAjSZqqgdjd1
         BGaunHzro+6OtZuMpQv2YiqzPvWo8acMRxgUXMH7YMSSJUnlDWsBbCJDDnv0ZfJSe5QN
         fsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792784930; x=1793389730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jcX7+w+8vvOIu+l1j/b12ERTdZM/yIWf3ikT9C1KkwE=;
        b=tnVNTfUQiRsaFIeLZRH5pa74aeid5nU3EiKTgoC6f10Ft8k7VZ2LuHZAaBD2KzljRG
         NWmV9kMr8UzDwkwQbAs2tanrS4v4gbRXW0KmHKNIQZxayyOArPfxFHNNwOSgKGV4RWgy
         jGqdeMa1qJ4W29UlB7oQvOOBeNFHvKotnP4GXxHs7t6yEI/AIS7CDZv+UQg2/nHKorFU
         VC0/kwZhjkT5ydLa9lBtYaBXbY5se+bPSYpi+2EE9RWmQsmCjJvd23FkKTqakIAbq2W8
         rEPi86yHz7yRc38eC5AKrWm33DywGqqz16ymoqMWfIFr6bx4T/ZolCEmsN4UrbhRLoNS
         AAIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPXpQGnsijQvlaDHKB+RT6ZQkyFv+6hArzoCd/EqAd+2Lqvfmfj8XNy8fxmfdm4u3jXwtbLg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJcT0//2JPnmjOURc2pKShLF3n6RYKAzJbUyJHSY0ULi5cVFVEx
	X67FNnNG5i+58RulcTWT9GVtU7oB2tfyVSYbFXco/mwrxa1tloP+9ls=
X-Gm-Gg: AYBFou2/qtv+2rz4ZQoyow2LaKMcdwS2/BzbsOElkJzCCIQATdV+6d/0IHKPbNV16Ka
	vQhqJ29XSmocUXhfMA3se+GkykUTM6y6OYSt73dahw4h6GsaBhXKe75dM5d3ayAYibIg6FeRgmo
	/7cr/BZ4w5eJYDRZynZ1K6RiPCrFRCmX73onugKLTeTjIYq6O+WHERnMwWHq9CMgnpU2dz06bm5
	xK8NTO+sLsEQXcStA2V9EbnFvk+InBkWIU5F9OysvAuwTAbyHiTP70z8py08LRNZcmXxFKUmLIE
	Qtg2R1XwZah74JAcjaIUM1tUN4/lECvHicCbM+4FHl8UxPhV/6vwJrLMjZH+mVD/c92ScwbRetR
	umj+MgU5ED69K4S47BKUtc6EbblBvF2fo0FQf1pWEpUjsBsf1po0OO23v0En+/72npwm1h/Ko31
	/rD6NTaopqS5hTMGey/KMW0ADmuU4uoXZ/JYaizAGowSEV7jqX/FmbIyYqncgKwyuzPmHEcm6bq
	eAsn1sjkcS+TnmskHOUH4NMSbbj8Y67vIWWTuw7g73kvkRt0JYuTd18jvZCPVm06WjgJRnxNO3c
	mXayKCygp1fe
X-Received: by 2002:a05:701b:4248:20b0:183:c7c1:879 with SMTP id a92af1059eb24-1992900a091mr110659c88.1.1792784930103;
        Fri, 23 Oct 2026 12:48:50 -0700 (PDT)
Received: from localhost.localdomain ([137.201.204.53])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a10csm657043c88.1.2026.10.23.12.48.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 12:48:49 -0700 (PDT)
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
Date: Fri, 23 Oct 2026 12:48:48 -0700
Message-ID: <20261023194848.2449-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022053227.90608-1-sj@kernel.org>
References: <20261017195747.89961-1-sj@kernel.org> <sashiko-outbox-176355@kernel.org> <20261018200808.379209-1-sj@kernel.org> <20261022041708.2690-1-ravis.opensrc@gmail.com> <20261022053227.90608-1-sj@kernel.org>
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

On Wed, 21 Oct 2026 22:32:26 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed, 21 Oct 2026 21:17:08 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
>
[...]
> > PEBS saves registers just after the instruction retires, so a load that
> > overwrites its base register defeats decode.  IBS saves no general
> > registers (perf reports the registers at the NMI), so decode is not
> > reliable on AMD.  Decode in kdamond must also survive exec, munmap, exit
> > and pid reuse.  These are synthetic loops chosen to separate the cases;
> > how often real code hits the failing case is not measured.
[...]
>
> Thank you for these testing, Ravi.  Unfortunately I'm still learning perf event
> and therefore not yet fully understanding these tests.  I will revisit after
> gaining more understanding.
>
> > So the suggestion is for the first report type to use the PMU-captured
> > address and load/store flag (AMD cpu-cycles:p; on Intel, the PEBS
> > memory events, which moves them into milestone 2).  Your call, of
> > course.
>
> Meanwhile, I will start with the current plan (capture register contents in NMI
> and decode in kdamond) if you don't have strong concern.

No strong concern.  Starting with decode makes sense, and VMs are a
good reason for it: in the KVM setups tried on Intel and AMD hosts, no
guest got a data address from the PMU, whereas every guest had a
software CPU clock (PERF_COUNT_SW_CPU_CLOCK) or basic hardware cycle
counter (PERF_COUNT_HW_CPU_CYCLES).

As quick background on why those earlier test tables brought up PEBS
and IBS: in perf_event, sampling CPU cycles has two modes, selected by
attr.precise_ip (the :p suffix in perf record):

  - Plain cycle or timer sampling (attr.precise_ip = 0, the default):
    a counter overflows and raises a normal interrupt/NMI.  The
    hardware does not record a data address; the handler just sees
    pt_regs where the CPU stopped between instructions.  Even though
    the interrupt lands a few instructions after the overflow ("skid"),
    regs->ip is the next instruction about to run and pt_regs holds
    its untouched input registers -- so decoding regs->ip gives the
    address it is about to access.

  - Hardware "precise" sampling (attr.precise_ip > 0, which routes to
    Intel PEBS or AMD IBS): the PMU hardware itself snapshots the
    instruction and, on supported events, the data address it touched.
    My earlier tables tested this mode.  Because PEBS records registers
    after the instruction retires (when a load into its own base
    register has already overwritten it) and IBS does not capture
    general registers, software decode breaks there -- which is fine,
    since in that mode you use the hardware-captured address instead
    (your Milestone 3).

So there is no need to revisit those earlier test tables for your
Milestone 2 prototype.

Two small tips for the prototype:

  - use PERF_COUNT_HW_CPU_CYCLES (or PERF_COUNT_SW_CPU_CLOCK in VMs
    without a virtual PMU) with the default attr.precise_ip = 0;
  - skip, and count, samples whose instruction does not access memory;
    in typical programs, only ~15-60% of cycle samples land on a load
    or store.

If you want to inspect what those samples look like from user space on
a program:

  R=AX,BX,CX,DX,SI,DI,BP,SP,IP,R8,R9,R10,R11,R12,R13,R14,R15
  perf record -c 2000003 -e cycles:u --intr-regs=$R -- <program>
  perf script -F ip,iregs,insn

(In a guest without hardware cycle counters, use -e cpu-clock:u
instead.)  Each sample shows the IP, the registers and the instruction
bytes to decode.

Thanks,
Ravi
