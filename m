Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4534D3B0
	for <damon@lists.linux.dev>; Fri, 16 Oct 2026 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.202
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116748; cv=pass; b=elfXcQbRcgXBrBaHYT9fMFWF5+aMFv2iYoBKktrnqNMpNCGF+4AFFtyIhx2xJNzE+DfyRV6VkXLWn4fzR/6F4dPQxaQjuBzUzm56S+fLL7wRk+oaiqP6EEJLLs1zlcqgrtbc1Km0djQxk15L7PRYImL22OVit5M2GOCxC+/zY7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116748; c=relaxed/simple;
	bh=NbuCv0ryWYiDtygGwn5WS0AeqhHnfIiKGVCd6AYwWkM=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4dn2Qxl3Uh63YqkoQBD8eYOMdjkf/rBdpGdEaIZG4b0T9G/l9IyLB2QrkcJnZVkkyBQpmy4fKJKgPFfh3gxmfeBPighOEIAhrDZqX8BnB7COAwO+NPd5cViFZ43C4eJp/lixviUgJcFOv6D3uiSGZiNv5vZrFpQ8r3QcSILD34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRjslBj3; arc=pass smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRjslBj3"
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-5179f3beaedso2203084b6e.0
        for <damon@lists.linux.dev>; Thu, 15 Oct 2026 19:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792116746; cv=none;
        d=google.com; s=arc-20260327;
        b=IG9oMjk18iQV9faQVSYBSBYTqZD8paztgNTzz5lcV5b7E1hLKMGZqY3i/pMKIThTyN
         lXmXQkASCuWBVgb7FdCUF+ZfnR30ECw+TQcvKoAH5BTasMEoAJR5+el3K5Kqrb14HfHx
         XNxJc/RdwyHxN7P+YLVftUqmz1v06qSqDA15A4W50rWbcdK7RsROttv7nV0WPo9GXT2M
         ujjcIW7mKekHo9nycYQX/XQ4P+hs+wnGwDNyjuT70g1MDRO1a+qKumPSv1nEqbXGm+HJ
         HryniHVaEKd51VnEm3CHnm8GWZumbH4H/EnP6Dp+czyCpcYLsh1Bi+8cna7a0vI3bTNZ
         E/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=NbuCv0ryWYiDtygGwn5WS0AeqhHnfIiKGVCd6AYwWkM=;
        fh=Rr9KKUQIyptk0Usp0VsQfuYsXGAhMlWjuIMEm9/D1S4=;
        b=GYP+6GNr7USS3NKpVrpLlGhqjxXkp1KUGLIiN3s8BX3hiPVuA2GU1cxG00qna+hsmz
         tlPoVtHXZtfOoshPuYFZy9Pn0ZCvUDBNo6neFiL5bhjpcSIOa4xWTdCgiIM4REtbt2ey
         0NqdrRNJPGEKYjy0sAjF7J82BgKE20ilWghTgnO9espuLNbapa6CXnYMKB1V3bWYGxIO
         JCcWV25DhcSYUYCJJsndQ4UHENqQlDnXCWBSML3xExA4ASvCEXQWNAFieS7SNN5NQjZf
         to00UGzirX/SAJAgKJWMTDKobEUbmXoRJVi7X1StDx7DI4Q7x9leEdnr5SzkhDbWvO5k
         PRWA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792116746; x=1792721546; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NbuCv0ryWYiDtygGwn5WS0AeqhHnfIiKGVCd6AYwWkM=;
        b=fRjslBj3tbFup5ikOS0wahNzD4NMq2GwGanqm/E2of2cg0SDl3/8X8++5liLBA/WjY
         owgwh66vV7EWtziI0jma7w9huPLDGAGMW0fP56Y69eK8oZKMIxdAyUChoKOorVm1Zuf2
         ZK0Sl2xSeUyr9ljgSZKPKWV71tubpVQkqv8bsGKMoqf7KDE9ucWgJ1G8iavtDGUzQKaX
         VCgqOqgl3eq1DjzSFUmb1j9ajQcFiN3+ZNRdyHO1ypWRZASOy3WxubPHSSqiLsFb+CLt
         9zHG9mTGG/swKRgx+q6nCgi7/DqZ0DddLZ6IT5auFA+m6cwgvH9Fiv+EhcSyjK8kzElm
         r/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116746; x=1792721546;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NbuCv0ryWYiDtygGwn5WS0AeqhHnfIiKGVCd6AYwWkM=;
        b=XUwh5w5Y+Ctl/CyPN7ltLM+3RuHjyzvTO+WsTVTjrF39jk/ZQgTp+jrkdhguXsSBdW
         hKolJl7sUSoZ2evmYgJtnKZsBMHczwoUljLKz7thFvQ44pX0YKSNQMU7NmTvYeVGSOeV
         0/o6Hfps1qVjLfgr/yXvofs9SU1mCCyKCUK1mnPcjFASXpbVCNyB9x0qR80WaOPahJyt
         SJgVwVqzn8V4lzu5hc546JitcWK/TN2gcPa7XPURD9cFUuR9YjzUdqW4DNtgVbAg3FUd
         2qiQpc6LHf+NhzkJOy5fRx0W26NgmKC0knvy2sYteCoixCvj5r+MNQX7dsbSsHgAM32c
         kJ3A==
X-Forwarded-Encrypted: i=1; AKwUvBzqea3ijRAqkdWkWUIplZwdueN7V3RHvj36iAaK73M4SUO4Hgbn6vgWmorC2iKHTDwYmxAJDw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLr3ouZFCOxnIbGtNubLnYdx7ITMzNrca6krdx0y9Dat3kMhIhf
	fkh3cyJYGAOLKzGpXr5fLInaoedv2J1qAd+IwiZj3rw6GxZKE+9zQC0UI1Vdlri6fiCfnuhYfli
	qWi0ES3dcmtLqRZXmJttenFJ46A5B5z0=
X-Gm-Gg: AYBFou3foAMXixKziY+R8n46DIIqnB3BkhiM+r+PyK/U7lTTlCbv23GM6osdbyRVYCD
	jJo8jFxYoM257Y/sHJXSCtzRsjhX2G3IdrJx0EoXZFaoxTELWDBU7QIvxLLqVreeLLWMiIGg/Zv
	YiPzhvSZr+lEPbvDyY8yqT9Rf9Wqk03jtGbWYu0YpBP7C4S29j+c8Wh9OEzYbMfgg7gvjkJjlvk
	w//AHs2CUBwW6LxqcRBLGcWKwocFUH/7kvyMXoqnp58eAxFGn3Pd0tJXXJF9itjvm4IruT940kO
	B8KTu9IqrKWvGAOOlMhf2GsisNlivaitog8wEmLpNHYhXSYbfqCoQUME0aZd/LLJoMwKn5e7HYb
	XUvTYjhg=
X-Received: by 2002:a05:6808:c110:b0:4cb:26a3:a0dc with SMTP id
 5614622812f47-50c4c7a5193mr21039421b6e.20.1792116746586; Thu, 15 Oct 2026
 19:12:26 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 19:12:25 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 19:12:11 -0700
In-Reply-To: <20261016012622.114496-1-sj@kernel.org>
References: <CANOyQmHhCJEbHpHUZ2P0hui+We7wxWkEde-Vh4k2rRXWovRYrQ@mail.gmail.com>
 <20261016012622.114496-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Aveline Noir <jm5905938@gmail.com>
Date: Thu, 15 Oct 2026 19:12:25 -0700
X-Gm-Features: AclHuK9Igmqn1XI8cem-R3h2TrMyNOe057Rl7_ZSLpCcuX45h7PRoh-LpcSd8JU
Message-ID: <CANOyQmHMRh6Sa=6N=hM8VzO0HRaFL0FxQB7An8=Y-X5GX36kmg@mail.gmail.com>
Subject: Re: [BUG] DAMON sysfs: failed update clears tried_regions snapshot
To: sj@kernel.org
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi SJ,

> Please do not "top-post" [1].

Sorry about that. I'll avoid top-posting from now on : (

> You shared 4 bug reports in very short time. Three of those are
> from 32 bit.
> Could you disclose the purpose of the testing and how you are
> doing the testing, finding bugs, and reporting those?

I've been trying to understand DAMON in more depth with help from
an LLM, not deliberately hunting for bugs. It spotted a few possible
problems as we went through the code. After checking the code and
reproducing them in QEMU, I thought they were worth reporting.
If that wasn't the right way to go about it, please let me know :)

> Why would the tool tries to refresh the regions after the monitoring
> is stopped?

That's probably not something normal users would do. The test
deliberately called the update after monitoring stopped and found
that the failed request cleared the old snapshot. It looked
unexpected, so I reported it to ask whether that's intended.

> Is this an answer to my bisection question?

No, that wasn't a `git bisect` run. The suspect commit,
`66178e4ec30a`, came from code review. I tested it and its
parent `cce0b334c310` with the same setup. The parent kept
the snapshot, but the newer commit cleared it.

Thx for your time, and sorry if I've caused any trouble:(

Best,
Aveline
