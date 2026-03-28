Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA81448E0
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 02:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774664815; cv=none; b=qFtHm5Vke3rcRRx0rWIO9LLJ2qTnhIiNvohXH3WpJfZw60vd1AQraV+/NPwYE9z4Ue67uR+JqDglrQ1zsizba8HensuBDYXsahTMBLBDLBiMq8FRuf4C1SV4yMRL/C2g29lxvazWYdLzbS/nEGvuinyDrvPiwAmMtzb4VWKWi9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774664815; c=relaxed/simple;
	bh=jdzQc+eKlFYbyyXzMuW+fYhsZuBH46vz5i2KPMP91To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFXhtEgjdYaA2MYtukqoAdN/cLBOgOQw4LKvDKKDZNmVbN+qHYLUK3Td1IsXCz5ppFXmDmcVfB851mauMenWk9m+v0ve3vKPlzwBnDSeBBU+8E48/b/6h1GRl4W/QBRNswgvzIivOsmLj/9Se2Wo5dbOxBKs/O2smSfZwr9hRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k65+lHNx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k65+lHNx"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35c124d2613so1865275a91.2
        for <damon@lists.linux.dev>; Fri, 27 Mar 2026 19:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774664814; x=1775269614; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb6J4It46FKMZR7TYBK4AeUBRTxKgKLr3E2XeVlLk80=;
        b=k65+lHNxunQowwqKXxsek1vCvJrU7ypr3KWQ0yUe/ci+MyUv6JgPyYH+cKGcHSApwk
         WpIM/IXe/jYXdQKFCclznolbAfX7L2l9pY46ByEVjxza0g0YiitAjSG8xubMt2HV9XRb
         98SoPUD+k0C7g273tlWV0BfxrdNN18Ap0BcFcXL6+9GMFKQ9gsjOuBlvugxhCPB00t+8
         J6g9HbyDbUKMAwvz5Jy3LkiSUechL9N5CyBtfrPIoN2JhFhYLDH2OzNkiCORf7epvLjB
         gVU1366OoUkfdmzH/Ql6rD92GQ7nN+RJ32Crn911FHI4DbmaqIXsyJsrCHC4mff/rdro
         oFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774664814; x=1775269614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kb6J4It46FKMZR7TYBK4AeUBRTxKgKLr3E2XeVlLk80=;
        b=CEZBWZ3YBa/0Hjr7lJagsr5QAUkjwIeUr4v12wce96K+Ui4atG4G/cKQsYHOxlVaHz
         8fSXfNtY7bQkos6+IvkIY43DPeb4gxQFeOxGO5g8B0HZq9zy+MNUYLWPicgXOKmnZhnN
         5pHX56H2p/0PL5gQBYsba1ZPxrLp++gvkuwvSaC7ZLpp2kSRkw2n7YimY6glD7TrTVfp
         wfWr9I4IE+L3ptf3e0HIrCOh1RFXQiXn14osVmDDhYA5eQcCA5UYV8xTvpOEYurPZJRV
         HBGmW0xSGRBknea5nYKrYtzBBpiDcoH5cgwLvsJEUNx0GpS7/YPJF743z6Vpr9zp6Pef
         Lo5A==
X-Forwarded-Encrypted: i=1; AJvYcCV6GFd5bQCTg/JQGKht++AE1izXSTnNzqJH0TDeNKiMZTc9b+xw+1BPjM2S2vLY0kLkoFnbmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwI89s7rFYM8GmEuUVkuBc6w/BzsoKzeqzmp6mnFcziVBJIu0M1
	49x8Cp2mIW8JMmCBxhwWsSzJ1cW9/N6mcKni12PPgfPgMFaV61wEsBZ3
X-Gm-Gg: ATEYQzzdofTNyM9We9uOwtgH3pUmqQTKGJc5rJhTutNXmSPHOZMPSXL/tPAU3Yb4Pen
	eM/OeP4VOfbTYp3Vb7kp0006no67XR01rkaJgpbeeUw/O4uzhi4C5vb280kPoNyCIo1ef6fNoXa
	FZeJ+wAmWr+1phJqRETc46Uy/zavtuAqOkaApHIFl63TIxubXdhBDidkho92H/IrzOGzFM8W1f8
	FIirsZGLcRUg8PuBn8q8bPO5RpAbpHFEgoUPfF7dKYyGkaT63ZXFiKvXzSMkFpoHuAPej9q2WM0
	am8QPX+LT6s6ZSGQ5s2S+kRDFrouvteavLCeN5/FrxRTYxbbz2DXLyK78bc6ZTBGER3F79Y0ZxU
	21myxq8FuTykQCLADM0UutstzvarWG/w0l59xP7zwoMhb1SEnOAuxU3tXa8xsRoxFxRi8+/0LoE
	KpEe4n9aqsa/5+ujUT0y2xI4PVr1852Ta/PdBznRYOEIV6bviCXGXA1GHd3R+U6w==
X-Received: by 2002:a05:6a20:7fa2:b0:398:abe1:ea8f with SMTP id adf61e73a8af0-39c87af31c4mr5044717637.44.1774664813633;
        Fri, 27 Mar 2026 19:26:53 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c769179e31asm412710a12.17.2026.03.27.19.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 19:26:53 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Sat, 28 Mar 2026 10:26:51 +0800
Message-ID: <20260328022651.41744-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328001405.4253-1-sj@kernel.org>
References: <20260328001405.4253-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

> It would be better to not terminate.  But not a big deal.  Users could be wary
> of the consequence, as long as it is well documented.
> 
> From my perspective, therefore, code maintenance is more important.  If we can
> make DAMON not terminated by invalid user inputs caused damon_commit_ctx() but
> it introduces a significant amount of code complexity, I don't think that's a
> good deal.

Thank you so much for the thoughtful response! I completely agree that
code maintainability should be the priority and we should avoid
unnecessary complexity.

Just to make sure I captured the full context, in my earlier follow-ups
[1][2] (in case they got folded in your email client):

- Does the current kdamond termination on invalid user input align with
  your design goal mentioned in [3] (stopping only for "internal
  errors")?

- Would a lightweight fix be acceptable? For example, performing
  validation at the very beginning of damon_commit_ctx(), and returning
  -EINVAL before setting 'maybe_corrupted' to true. Since no
  modifications to 'dst' would have occurred, kdamond could safely
  continue with its old configuration.

Thank you again for your time, and guidance. :>

[1] https://lore.kernel.org/20260327064517.68131-1-aethernet65535@gmail.com
[2] https://lore.kernel.org/20260327121009.38374-1-aethernet65535@gmail.com
[3] https://lore.kernel.org/20260319151528.86490-1-sj@kernel.org

Best regards,
Rui Yan
