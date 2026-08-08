Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDE31A6825
	for <damon@lists.linux.dev>; Sat,  8 Aug 2026 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786226147; cv=none; b=Y/sL1lo7xHvYVqO0N5tPcAQZkqEUZbW2iUloHGs/JL2S/FeTSp443ivHoKywo/M4rbbGsD9IeYNSdd3nNymw60MXitnfEzlYH4rxxEQmArfzIsKzz+bmKsdiAUhO337AW2Xo5SvCFmWSXv1b7c3Cd1Evkl/+DBhd85DqUkjgHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786226147; c=relaxed/simple;
	bh=G1nJ5J61+v9TqF8JceuCFhn2VNqORy6y03CEZ3fzzhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReiG2tGaVVJYmdA6ngYhDv8EFz6gN+WvXrza6d4O/0JbDs3hCF/3/fD21/k9cLNS4NYNw10+k8K+20PNtOQ3Y0NZv1yXTEJIEV/MVLRaL2CjPNe0Quqy1dWwCxIHwv3kfoRwBr+rlTKZsSwglyn1N6H+APBnTWZrxwVVXuB9ow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHmndpmX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHmndpmX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so782672a91.1
        for <damon@lists.linux.dev>; Sat, 08 Aug 2026 14:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786226145; x=1786830945; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NIBD10vb1DwFw6PnsMzh3QUfgDMJOzsEKlxhhdBqW4Y=;
        b=KHmndpmXdKoTGP/f9fSeBk9/OfSCbCJtgmu4GGEq9HtqddVe95Msx542UaxHn5z3D3
         MZmfMvGErni3/rJr+D0ystz3wax7rihicWWTYLA8XMjjPp19kvzdFEL6vHw5lHubuJb7
         BZ8scB3IwgGxK+ngRom57GM3xpswCN9YIWLIiSiSXe70bRjjqCWBT4C718fC6H1pK9ye
         jthUJGSs+/grtuWgZEhgeHydDQ2elD2DNF0l2GwEkudguI6b8tGwkiSdgiMz8sy9nNP8
         4UDGCrswQXFCGXKv2fK804a7WS886lVMvK+Ph4LqjdEnl2+MiSFsh8NV+Gfyq8xEMu+p
         GrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786226145; x=1786830945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NIBD10vb1DwFw6PnsMzh3QUfgDMJOzsEKlxhhdBqW4Y=;
        b=LLxKTeVCnJwTY7Lm8g4q2+ZstohSksfZ+xXGKboEE6QXqDwW+Kj45EUDlvbirRND/D
         tmE931WfM/AkgJtiHL72xyhDSGW2YKxkJql3wlmgYpilucZ/9/EL+1Axvh/zQEmYBZOc
         jGvKDRm5nvNmkbU7y56D85s0nFgVhSE+XejArBdqjmsYx2mcj7COKWOyYvaTGmYdjAGH
         9NfryZMFLkdqaHcWEMAUlcU8G8f3lPyYjCJK8Hws1+EqhNTFyykEAeHpQfalnKsB1OCb
         rmz/ObzrzV4oozcSa4rqchpt+lEgqqcM/4/BoJJZEYz76fKIf4PIPbggwOfM+jO80hPn
         bS2w==
X-Forwarded-Encrypted: i=1; AHgh+Rr0TFkKHfnVjjGsJztYRnOzeSGqJNY+efOwJjTnTq8vPooATLwk97mdmwa+nal3ohjoO76DiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpjUqotZz/iqud2PCp5CVjqHt71VFjdxOhjjp9aYXOeGyN4u6j
	avV723Gqrz1HMPj4wpaz/xWQPYCqcu6B8nZjJZ7Qni142M/3uigxyAXp
X-Gm-Gg: AR+sD10fjTQD63a42DHIhTGO+vODtieWEnpO0OviBEP+JRO0+K2QmMKq+5ognuUqx0P
	NUgLYp+FjN3+e8tboymrUiFQhdQdxB71Qsk1eI7QMmrVSUppFiaQTQhIIkeXSc6AJJO7vli65Nf
	zT3fsYAYOkS5Jv9OMbXA/SO/USJOgm5Y2SefAkaAkMcNL84cN28VuEFWLNG7hlu9Sop/L4ap+bD
	X73aiJMNHo8eEeBo6SdJ+w8RE8EK8IUJKFsMFTU2rH13NxucRUDXLVh/H//jar1pZ+l+K+HlhmX
	a/AI1n3XqVcPu9qFR9w+WRPj6RuRbQVYQa4CvEbH/QBcNE46+VmOZpVaDpANXHUAFZueSfbitxq
	bR0PHNPNYTUcbPpNTX2B1Zn6cVcR3SDsP05U1XykvSSF2mguG0xtfRUnoONCZe6aaresP2nsY+N
	aSrA4Q9neH7xSBUuU6fuaWMN+b9Se8lQ3d8GzBHWN5ijc+U0xsOyNYbmP737hYjTVfze3tXQgc/
	4lYZDiVNmGu1oH/4oyb9aMPLVY=
X-Received: by 2002:a17:90b:3c06:b0:38d:e658:595a with SMTP id 98e67ed59e1d1-3903c54f1fdmr31877205a91.2.1786226145253;
        Sat, 08 Aug 2026 14:55:45 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:935:f4a7:6f5c:e816:9aba:2090])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a9220sm25317320eec.7.2026.08.08.14.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 14:55:44 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/damon: skip deactivated schemes in watermark checks and add fallback sleep
Date: Sun,  9 Aug 2026 05:55:54 +0800
Message-ID: <20260808215554.6045-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807140739.91238-1-sj@kernel.org>
References: <20260807140739.91238-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

On Fri,  7 Aug 2026 07:07:39 -0700 SJ Park <sj@kernel.org> wrote:

> This is an intended implementation.
> 
> When all schemes are deactivated by watermarks, DAMON stops monitoring.  It was
> implemented in the way because we didn't want DAMON consumes system resource in
> the case.  But, later it turned out DAMON's resource consumption is really
> negligible.  Rather, it is turned out that it makes DAMON runs with stale
> history when it is activated again.  Particularly, regions have 'age' and their
> start/end addresses that was emerged before the deactivation.  Those are
> meaningless and could even cause wrong DAMOS decisions.
> 
> We don't want that anymore.  For a case the user really want DAMON completely
> stops, we introduced 'pause'.  For max_nr_snapshot-based deactivation, we don't
> intend to completely stop DAMON.
> 
> Maybe the documentation can be updated to further clarify this.

Wait, according to the documentation and the code, DAMON will still stop
monitoring when all schemes is deactivated.

    static int kdamond_wait_activation(struct damon_ctx *ctx)
    {
        /* ... */
        while (!kdamond_need_stop(ctx)) {
            damon_for_each_scheme(s, ctx) {
                wait_time = damos_wmark_wait_us(s);
                if (!init_wait_time || wait_time < min_wait_time) {
                    init_wait_time = true;
                    min_wait_time = wait_time;
                }
            }
            if (!min_wait_time)
                return 0;

            kdamond_usleep(min_wait_time);
            /* ... */
        }
        return -EBUSY;
    }

    DAMOS allows users to offload such works using three watermarks.  It
    allows the users to configure the metric of their interest, and
    three watermark values, namely high, middle, and low.  If the value
    of the metric becomes above the high watermark or below the low
    watermark, the scheme is deactivated.  If the metric becomes below
    the mid watermark but above the low watermark, the scheme is
    activated.  __If all schemes are deactivated by the watermarks, the
    monitoring is also deactivated__.  In this case, the DAMON worker
    thread only periodically checks the watermarks and therefore incurs
    nearly zero overhead.

Should this be changed to monitoring will not stop?

Also this patch (0002) add a new function named damos_is_deactivated(),
it checks both wmarks.activated and max_nr_snapshot conditions, and I
replace the wmarks.activated-only with this new function.

I am sorry if my commit message has caused you any misunderstanding.

Best regards,
Rui Yan
