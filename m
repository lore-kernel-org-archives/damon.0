Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434426;
	b=cvWbvnNFqoZHKXjwlElGEeZBPueeYtXzQwmz6RdGhEFAGXkVVBDmE9GmAz+HUq9C89Aa
	 yYpKvyAnEUrJoYLUs+NWIHtPxwi5UOFwgceI598SgDQSQtkELUs/Wl7w6CmDDih5q4vZH
	 Dx+fwq3KNbsQyHyRLfn6JO4iaz6wf7oQY6DY4AyN93Hm9ntXulg91Q9oAVQepyc8HGQZr
	 SR9adbgDD9n18Mq1nSXd3X/hlQ6SprVp9DefHpd3uc9gfKw+NeqrUUUmUdToYASOtpm5m
	 Jf0FJethM9T9YrrAjL1yE9vi3iVPx7VlnoicyCo0zGB3zYp4p8Ddc5Irx2aASKVOErg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bg5FSTN0ePe7eQMCpHVjKBFbVINT9B2P1+zfAPuDdmA=;
	b=etYdavuUwLo7cB79D3exCNrDuMzKfhwAMeKL5CsS5hfPiclFpMifV8T+S/doRC69RbNg
	 l8XTwpJ+nzY5w9k7HYQ1Y25jk650k5T7/0VFQefym8i97xQ12hr00Vt8oit1v6KMdxr9S
	 tgQGGoH+HEcW48SqhVNvk9wZKkZRdjhwfu7N+twm90WztMTLPFY6AYzRTqkr9kdri41pG
	 h5RjyX6KZOo1poXVI1lPeehMb+wyhdWRt8DOYAw3FGzMn9TUfpu2yTdQ5UOJM1adY0thO
	 Nd4JjuOsJpUbU6/Xq0526a8EiKIBKqR+x/fM2X8Lw48TPjjQhFAGo9plZowjpA2JLgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cd4D3ife;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3C606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 11:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CE3C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cd4D3ife
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cde84cb8803so442038a12.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 03:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795434425; x=1796039225; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bg5FSTN0ePe7eQMCpHVjKBFbVINT9B2P1+zfAPuDdmA=;
        b=cd4D3ifeRFgx8n9sTwYpG3AEN3GWqoL+WzZ2HZ46V1+VPEXmtUpAJgvEsy4TOnZBCf
         xt5s6+RAo1VpKPsAONo19Y2rwxgAyvCTpnHvUDnmIDJc0HmSkjyD1WVPxiZP2TKfKX1Y
         fEphLayGYxW5Ap8tmuNSg/lHCbmtLyqYxIu9g8Jdky3m2bflPylOuQPt7PsM+rq4Qs6F
         BzGoxPZwfzd5aj1I393q26FG7Aq7q/SMlty0wU2ih/xfCPH94pxORgPv0t9TuGDeWrFj
         fadlytXSYAabEP1qFLdos2pn4830kqJ0gk/frWrm2M5mc3CLBgZwQXOXjf3iEwMueYJT
         fWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434425; x=1796039225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bg5FSTN0ePe7eQMCpHVjKBFbVINT9B2P1+zfAPuDdmA=;
        b=21gFWUrjx1IXqpfdxYiPriiPMNhmlwKQB8BjuY5HzQ2hVqnFR8zRDr6hUfSFy3t3Ku
         Aj5zQ+TQDjCDk+hXDKwaTBgOiT4zMLVwtP3T4Qlj3bFDcRQx6DKkw+njE/V8FgW39kwa
         Bqlkf3VNW0ld+4s2HEoOaVp5Ngz+6Yd1c6OvuJKCIldrhCIg4xpimd4FPYZVKwtp7rxO
         iDw+C0UY4tELpeXhmmxtn/8wQs6s1rMfLu720+ac1Hw888kKcFnS00/7kUzZGW9b2hWo
         q/S6rk0E3kJMJVAaRhKo2Idb3aNYxm8JOym1/Ud5f6RQYikWjvTmuPxDSwkzP9FPI0jr
         G6QQ==
X-Forwarded-Encrypted: i=1; AL+hErFr/nuZPFujjVPhQEw6fmfwC/0UGOe38QrGaMY1lyN9PZJIXGQ2NWvKIWbOiBA7Kb3FysXCqg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+mg/VpC8CuHllE9sZ8dK4NFqz7u6iAndeU8SUmgNKAbpj4E6vS
	MFADI9DuyHF9o4SVBmUJIsSl2AEeuaw95qf/1JsiyEbF/locqitfiGh1
X-Gm-Gg: AZFdTZfyiEYtNYB9eD7614h0hS1FTfZ50tjLYDB5F2TTWiiy6lNhxhbtoVRc/Cx9ETJ
	A1Wt7ant+DrDoMNhwhUxksK8Z5id0a7rbSOwo0f4+80kmpHvnCCiu2HP5n49r1m7EodEbP1QMc9
	p2bq0RZiIxqnzHCbf+ImRD0xyvPW7Pssezur8nQ3GlOJStxWUL3uEagiZkh9Ewt2MhEUcMG7smC
	h4tUiP/lVjsHpG2y4XY4OwzYTAikzeioZ5d0tuzGK1MndIP/3B3ohqBf2m8kfrpC4w0DtoVEMvY
	+aszhsBBoqOqb8yT+uXAJ1LXO4F2h07AF+kHc+1ei41WjmeSlsCsGd+dzGjf/qFNfYn8jcXX7OO
	bWjs/uE4Fgqz66NQ/Aw02WhHhGqbnYFS1RC+/A1HgkMKrHMQ+SjScbCxVAAIljaeOW3Xf/xY57Q
	o+OSO7aaqUX/jSRINZduM1fXZHWmNlTdC04wtqq635IX2RpCUiqAi2uXjkcfb1unrGWwVyxn9Sq
	fJaxk+OMKUIytk4XkRKk4bwddDX8svXfehTmxS9awt00y2UWlWRPwZFV43PNKHB2+0aKmzegnXE
	UwuqzGKqmB0RF1dBI0JOkHhpQiIFlCa9edbIMY/mvVRhAHkwrQQ8U+LwkeYhvZgkWxS/
X-Received: by 2002:a17:90b:3f0f:b0:3b4:1b37:ac89 with SMTP id 98e67ed59e1d1-3b41c8ff71dmr15235429a91.34.1795434425295;
        Mon, 23 Nov 2026 03:47:05 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm14380045c88.4.2026.11.23.03.47.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:47:04 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 05/27] mm/damon/sysfs: add reports/producers/ directory
Date: Mon, 23 Nov 2026 19:46:32 +0800
Message-ID: <20261123114648.7138-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-6-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-6-sj@kernel.org>
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

On Sat, 21 Nov 2026 12:59:49 -0800 SJ Park <sj@kernel.org> wrote:

> Add a new sysfs directory, producers/, under reports/ directory.  It is
> a placeholder for files that will be used for controlling DAMON report
> producers.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
