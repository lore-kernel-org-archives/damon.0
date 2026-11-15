Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794776970;
	b=1YcU0/NBevAOXA4Mg2CuD1ivkGfrztr9ixjKu1YrbeYRs/W0mFMbVhFMdMUa+IhLpXy0
	 qbVDnhpx5IGVNSUR4gB2OclCm8uZMhLZt91cGputCU6qqvYlSVmdE3OAGgBNhkQdMvL6P
	 4xzHBHJVvAIqMxAigtpZyYt7axrWVcREOlZgCwC6lyglV3ZbvVOh+fQtTmYy1jxYxPAJf
	 NGWj8zHACnCM0n0ObV30B8C6LdrlJFPuruMzZCOoxqFgRtAyV5GeCPg/CdIqfN7bUKGuN
	 Voi+uPR2+gRH4DrhTBJxZcR8e8eF8bPxE/gW9OuES9IzD2m4QOeZ0WIEeJ5YE1bUfZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794776970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WIxMAhHIgqQiK3JeHg/MoUdkFWwJF4Zy1XHbF7nLUlk=;
	b=tD4Md2ZSKjg/3KNRl9IM8E9R0VrStiVPRrShRNjnP4wXnzAFv0pzTR5fy7bo0BRY9XuX
	 Kw+CVLKZZ+HRZgd0dGKqKtibnvxR2VE9ZDw//ukp+VgfQUIu1wQ06ikgPg/Je1ZfQJxXv
	 FrT+Q96JGmfVeoErqME9hw0tXuVN9G+hDWBxP9Ox7xUMBAMxEKs5T/bMfM8aHQ3ViRp39
	 7ACL76geKwmLhKt9FnV2glMWgDZWVmPMvqQpqmsSNgN7Jw+AHuAY6r51i1q/pj8k3iQ/3
	 IDEZB/8EidcP1kAAZB0dddxBnhb/LzTx4IczCYqiJjnpWnsgYhF/3CTotNKT0XKAjQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vf8Th39W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A4B606A323
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vf8Th39W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26C01F000C4;
	Sun, 15 Nov 2026 21:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794776970;
	bh=WIxMAhHIgqQiK3JeHg/MoUdkFWwJF4Zy1XHbF7nLUlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vf8Th39W8aEvthNwZAoSMhIT3m3nSVljDh+VPZSChi7xIwA1x0uMtqcVTUqb/tw6y
	 yxGOFjUFxUAmY3zWjArPoJYormorz8ZywUfXal6UDa2KZkNxZFfwGA+hxndFbk6Yhd
	 UNpGWW9HnRLaNsI6p/k9Cu6S62wvuSDuwVn0dLIiEbadhlajxFObiLBAwDBTSPUkwQ
	 2y+ST6GltxvbhE8VrdY5+jNOoRLLoEdfZigkGhlavdsIi+xBakaYJ79JFwmvfR3vCT
	 8Ui00UVdGfUZgMq04f9QLeWt2Pkkzx71G3o93Y2KTIPpfUCJT+baI2N1B30tdRjaDu
	 g6vd1RzaoEt+A==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 01/27] mm/damon/api: introduce struct damon_report
Date: Sun, 15 Nov 2026 13:09:16 -0800
Message-ID: <20261115210917.100412-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-215838@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 15 Nov 2026 20:34:31 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mm/damon: nonexistent fields in struct damon_report kernel-doc
>   comment
> --
> 
> commit 919e8293a0141a206eb1e31c857deac8b6249a6d
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/api: introduce struct damon_report
> 
> This commit defines enum damon_report_type and struct damon_report to
> represent data attribute reports.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 06bd92981af21..5c32ddebf4625 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -751,6 +751,29 @@ struct damon_intervals_goal {
> >  	unsigned long max_sample_us;
> >  };
> >  
> > +/**
> > + * enum damon_report_type - Type of &struct damon_report.
> > + */
> > +enum damon_report_type {
> > +	NR_DAMON_REPORT_TYPES,
> > +};
> > +
> > +/**
> > + * struct damon_report - Data attribute report information.
> > + *
> > + * @type:	Type of the report.
> > + * @addr_range:	The address range of the memory to report for.
> > + *
> > + * Note that the @start_addr and @end_adr represents an end-open range.
> > + */
> > +struct damon_report {
> > +	enum damon_report_type type;
> > +	struct damon_addr_range addr_range;
> 
> [Severity: Low]
> The kernel-doc comment refers to @start_addr and @end_adr (with a typo in
> "end_adr"), but struct damon_report embeds @addr_range (a struct
> damon_addr_range with @start and @end fields) rather than defining those
> fields directly.

Good finding, thank you.  I will drop the last line of the comment.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261115202849.99134-1-sj@kernel.org?part=1
> 


Thanks,
SJ
