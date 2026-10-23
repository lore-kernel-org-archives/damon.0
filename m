Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785086;
	b=Tsk2tO8ttV1UBPQ1gS1Rkjj86HC+X+Ml+WV/jNqZRi5Qpfmo+HRXCnIn/5OR7KXlnOFw
	 VKJxVlIQkHrPHIkgy1/Qe1ioP1eGdnC8DBnAzzNN/mH0FDqF2Qgqn7A5mt8QpCj2Uv6Fv
	 ctn05lpSUIm20SM++IJZpBwYttA0aA3e/WP/IQo5oQFSgOMte2suo/0Mzl6hiPYPNTOeu
	 13npDqQvJkGZZMkofpPqnuRvnCMFqd8MXenjJNEuPam/VD2OBZdLI61KGmAC+lm9F7n5S
	 BZq//wjlKDcHI7P4ttbWm1lXhFmWuSPcGl7IHlzi8+Sz3jIJGSBMXgYmbwuufkVvHzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ajNcFZ5WussjgJU9fT6tDOCdCs4dRuGUCjNnd7n+pgg=;
	b=eZhwFe2OrEIt1FOj6qyDl57Af+pE9DR8kbCzQpHE0S8G2T4QYBB12G/QMNebQ3gcUg34
	 RHiORzsT7tSTSRdgbi85feOFRYwLyCGnYvctDUoi6Tiu9ogtIK4USm+ndoYTKDo0Mw6Gh
	 wffrUHigRcxMSh6hFjrf3aRj/v5z8+pDxDX44jLuBylPC80Hn/w/IeQ4IF9qivEIPndNy
	 4lGv6kIxim86DfBz52/bUrDxYU3jcTpfHZdIL6Bl5m0QcrOXCiS0n2zpouHOWXprl9nLQ
	 kFX7CJtt9dajxgaMcCqxbobmNdIx9SN5/LCV3wwqjd8CjuHna6UfP1Trl/Tv1FFFZAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FXXFh0Sh;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C0606A31E
	for <damon@lists.linux.dev>; Fri, 23 Oct 2026 19:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 447C0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FXXFh0Sh
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-33e48934fa8so543963eec.0
        for <damon@lists.linux.dev>; Fri, 23 Oct 2026 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785085; x=1793389885; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ajNcFZ5WussjgJU9fT6tDOCdCs4dRuGUCjNnd7n+pgg=;
        b=FXXFh0ShZjkvviTJlWSFAfZGSb0+I4aQbJs7NXg5ntcYhRXc19DRwapoRhRSqo5age
         JrP8Xcxula5THJX8yPDKwHLtmoQVPxYPfsZ/4TOEBvHA2s/hNqjxncDOL3qV2SMIcWW2
         oqj7XlR8vMwktrrWzTXlpMHvFmkQD3pg2JMfZ4N7C7UG4nKjFqMPYNUmDNwbqM53/ykf
         xpSr4B5BX/LnIKk1/u+Zpxbr9NvI2ft/3DdxGbIsBwO91LD4Opx5Qo3MptIS6cdK/myZ
         ZjrovyvqBTc5VoAornzYWG7c3e5b7bmnWG6hz7ce7OQswbE0qXxgeYaEZLx6d/NDFljc
         M4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785085; x=1793389885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ajNcFZ5WussjgJU9fT6tDOCdCs4dRuGUCjNnd7n+pgg=;
        b=qik+N89d203IFXRd65jWxVwpT/KlfK2Syw5EbpyVNnjzWoqTUBK5TY4Qr11jkmB+uR
         EfViOX49+aj6WqpYM+mIuIMviacI3DFsBNhS4CSKVUWIzZcjJtuCWcZ6uJT7EoRuwOUB
         LbBip2CKWkFvuR9/orfVJeN9SYmC4ztSSv8bflqctHMUBl9yx6T9zs5qArwFUeuGrxTF
         tW3U1nbSwJmZS90Dlhc1Q+L4dY+pnbQoVo7s15olMH7eDVnbPCqcFp/ETzA+u3xS65IF
         bpSDtictSKsmepf9KitbsMwBghmL84cSGM0X0ouoCut82a5n25EvPW7KrwAes9+WGZ/F
         vOIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhYKjav7qGvZ0WzGb+t7iX083SJXW/9y8bTZUgTzYH2cizBJ92eMlYZ5kc/3ubhUu0VAQYdA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLXrYGVC61J6yhDqePfX/7vdmEIsB26z9mWQigsp+17SlIeSEk5
	bY9ZWKweXuJNxFzMjKVY9vKQs6o4wzeOjyzSAs6erHn2eMlAhAMG9gcbK9eXf5dkMHCB
X-Gm-Gg: AYBFou1oc3nX6dfWuhPJWLBxunoVd+ottd+KlwYO/eO3Cq77Vd3d0f44rs+Vxe3Ahyn
	r6WL0LA9P/f6GcScTBcRo7iELbmB61JLE5YuOm2WzI3qxwdpNwScrnX2T2v5WJ/ypSb2xiwD1Aa
	e8sheZhl3o3U4j/DwNYKrShduq08wbk+ftUP067iFU0R95jDc7GzzX4upvITmTzb5f/KuAgQayL
	uENIatVz+b9lkIyGVUwxjioaAEZtul76w3SGygNmQatGjTlZMcIQhxXv2L015AjT+q2WVDkzzU9
	zyRxt/FPW2bYA8gduid/p7v19940jwB1nURVSl/teg73dz8IuvkqmI4UuVAxFbdveqfyIMdSUgK
	OnkqqhUVPTEoVHXEhzBb95xz2PJbGGQt+NcmwPXehTASLUpOY3KIcu5wHBa9TLkr37F2FBuXqNG
	OqmzPeWd33ROsAW4hQNfJ4xY2xBUK8akskZpGbFi/EdBG/LqleyDbD+KT4bgeQgae5Xp8NFG4gm
	six+jwulEsWDPJUfTCmNbtb3Jw2fVlvqfoMdoISwoBBilAiWDZ8uUxqD4sWwZ0AZILyF4+MBwW2
	9jXLg65czj8vRQrdpaG3P8gon7DPGPCXfg==
X-Received: by 2002:a05:7300:50c5:b0:368:e6b5:35ad with SMTP id 5a478bee46e88-369e84dab92mr442217eec.12.1792785084531;
        Fri, 23 Oct 2026 12:51:24 -0700 (PDT)
Received: from localhost.localdomain ([137.201.204.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ee72c0sm420489eec.29.2026.10.23.12.51.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 12:51:23 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org
Cc: corbet@lwn.net,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: Re: [RFC PATCH v0] Docs/mm/damon/design: document data attributes report infra design (beyond page table accessed-bit milestone 2)
Date: Fri, 23 Oct 2026 12:51:22 -0700
Message-ID: <20261023195122.2481-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022052913.90437-1-sj@kernel.org>
References: <20261017195747.89961-1-sj@kernel.org> <20261022041724.2712-1-ravis.opensrc@gmail.com> <20261022052913.90437-1-sj@kernel.org>
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

On Wed, 21 Oct 2026 22:29:12 -0700 SJ Park <sj@kernel.org> wrote:

> Hi Ravi,
>
> On Wed, 21 Oct 2026 21:17:24 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
>
[...]
>
> Thank you for your detailed review and testing of the first design!  I'd still
> like to try decoding idea first, mainly for quick prototyping.

Sounds good.  Starting with decode makes sense, especially for VMs
where hardware address-sampling PMUs are often unavailable; some tips
for the prototype are in the other reply [1].

[...]
> > Yes, if the report has an address field with a validity bit and carries
> > the producing report-type (attr) id.  Then IBS, PEBS, Arm SPE (through
> > an adapter, since SPE uses the perf AUX buffer) and device-side
> > monitors all produce the same report, into the same queues and probes.
>
> Thank you for confirming.  And yes, I think we can add more (union) fields to
> the report structure.
>
> However, could you further clarify what are the validity bit and attr id, and
> why those are needed?  I'm still newbie to perf event, please bear in mind with
> me.

Neither is perf-specific:

- Validity bit (or union tag): a way to tell whether a report carries a
  virtual address, a physical address, or both.  For example, a decoded
  sample has no physical address if the page is not mapped.  If you use
  a union with a type field, that already covers it.

- Attr id: an id of the producer (report type) that made the report.  If
  several producers later feed one queue (e.g. perf sampling and a
  device-side monitor), a probe can filter on, or weigh, reports by
  their source.  If each queue only ever has one producer, the queue
  already identifies it, and the field is not needed.

[...]
> > 4. Binary search over a sorted region snapshot (your todo in
> >    kdamond_apply_access_report()) beats a linear walk from about 2
> >    reports per interval for 1,000 regions (a model, to be measured).
>
> Yes, this efficient region-report matching would be important.  We could also
> consider starting with linear walk and later optimize, though.

Agreed; starting with a linear walk for the prototype is fine, and once
it is out, happy to measure where binary search starts to matter.

[...]
> > 5. Samplers can stop silently: in a report on the v4 thread [1], IBS
[...]
> Unfortunately my understanding of perf event is not yet good enough to
> understand this in depth.  I will revisit this after starting implementation.

Sure.  The one part worth keeping in mind from the start: a sampler can
stop without any error, so a counter of reports received and dropped
helps tell "no accesses" from "no samples".

[...]
> >   - The queue: the per-CPU seqcount design in note 2 (suggested), or
> >     ftrace's ring buffer with one iterator per reader.
>
> My current plan is to use DAMON's original simple lockless and global queue per
> report queue.  Let me know if the report queue design is not clearly explaining
> what it would look like, or there is a clear problem.

A global queue is fine to start with, and the design is clear.  One
thing to keep in mind: perf writers run in interrupt or NMI context on
all CPUs at once, and an NMI can arrive in the middle of another write.
So reserving a slot needs to be lock-free, and a reader should not see
a half-written report.  If the design already covers that, there is
nothing to add.

[...]
> As soon as this design discussion is completed, I will start prototype
> implementation and share it as the next RFC version, as soon as possible.  Your
> review and test of the version will be super helpful.  I may also ask you some
> questions for perf event and your prototypes.  Thanks in advance for your help.
>
> There are competing works, though.  It would take time.  I expect about one
> month at minimum.  It might take longer; Thanksgiving holidays could be helpful
> to give me a time to concentrate.  Please bear in mind.  But once the initial
> prototype is implemented, I believe we could quickly iterate and meet the ETA
> (LSFMMBPF'27).

No rush on the timeline; that plan sounds good.  Please feel free to
ask any time, and I will be happy to share the test programs and review
and test the prototype when it is out.

Thanks,
Ravi

[1] https://lore.kernel.org/r/20261023194848.2449-1-ravis.opensrc@gmail.com
