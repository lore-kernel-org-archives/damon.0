Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337832D452
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774706948; cv=none; b=ML3/wMoJKai8LAF1hwjYdf5heeXJjImpDV9tTGzuXjtfVsh35fxH27a+H0eVYe2DXzfEEH8trtXSaeF4Jx0fsSPZLc9anr37pvstbKZvIaQd3s7Rf0peA6R85619RgP2inLdwDFFSzum1kHiQpB45CtMbATWpBqD5ECH2wsaOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774706948; c=relaxed/simple;
	bh=RH/HWSCiN4u2TczIYbCULCcVSw97zuiwD8lfgVnonpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHfI3XTpLSSgxkz54tRYsJekXuRNdS3ek6QWN8wBlF8XFe1ynEFbYaCAztz6DJpZVdQNhJOIUKtTwpzP6eywEOch2vsJSCmTZRxrmfKYCWb6vpaJoUcPavQup1KjgdDBsBXvQqN4lkmDcNSqLwKyySJzTswR/RQ4Hyf2QxeGiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxtFOkmy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxtFOkmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C2FC4CEF7;
	Sat, 28 Mar 2026 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774706948;
	bh=RH/HWSCiN4u2TczIYbCULCcVSw97zuiwD8lfgVnonpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QxtFOkmy5xzW92dCoMV1zhUG+Hn5lF3wg9JH90VQ58i5P64hkhu+NGVq6GSJ7Uavm
	 eD5cLmkbCh6ohHPIjHJxpOH20iwRPr5P5Ucv53R9loQ6hZyERumgk76R0+zoalg95P
	 wHZfyonQ3vMJ6xsw6RMs1As//X/oxfz8jzevb8D5lhkH74KAB1KIqd8w4UL02m4rMi
	 2+k+sAc8pdNw4uEdMYiKxb54wcsNKgfke4BoGxMfQwWD46JRjBsVxaLgYtthd9tlJV
	 eylRCwHXV5b4J5aZ2bpT0H5fWek3cdzJ19uNHwHIDWEKSVxcIQrGMmMaTl1tnHFlu3
	 ZoA0KSaq2Bi6A==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH] mm/damon: add synchronous commit for commit_inputs
Date: Sat, 28 Mar 2026 07:09:06 -0700
Message-ID: <20260328140907.10389-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328104450.14719-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 28 Mar 2026 18:44:50 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
[...]
> > > +static const struct kernel_param_ops commit_inputs_param_ops = {
> > 
> > The previous module_param(..., bool) macro used param_ops_bool, which
> > includes the KERNEL_PARAM_OPS_FL_NOARG flag. This allows parameters to be
> > provided as a standalone flag without an explicit value.
> > 
> > By omitting this flag here, does providing the parameter without an explicit
> > value now produce a parsing error?
> 
> To be honest, I was not aware of the implications of omitting the NOARG
> flag. It was not a deliberate choice on my part.
> 
> SeongJae, what are your thoughts on this? SHould we stick with the
> explicit 'commit_inputs=Y' requirement for the new synchronous behavior,
> or should we restore the NOARG compatibility?

Should be a no big deal.  But it would better to keep the compatibility unless
it makes things too difficult.  And it seems simple to do.  Could you please do
that?

> 
> > > +	.set = damon_lru_sort_commit_inputs_store,
> > > +	.get = param_get_bool,
> > > +};
> > 
> > The commit_inputs_store function parses the input into a local variable
> > commit_inputs_request but never writes to the global commit_inputs variable.
> > 
> > Because param_get_bool reads the unmodified global commit_inputs variable,
> > will sysfs reads of commit_inputs unconditionally return 'N'?
> 
> This is actually a design choice we discussed [2]. Since 'commit_inputs'
> is now a synchronous trigger (or a "button") rather than a persistent
> state, it doesn't necessarily need to store the 'Y' value.

I agree to all Liew's opinions.

> 
> > [ ... ]
> > 
> > (Note: The same regressions appear to exist in mm/damon/reclaim.c)
> 
> Thank you for your review. :>

Thank you for reviewing the review.

> 
> [1] https://lore.kernel.org/20260327233319.3528-1-sj@kernel.org (Lastest
> but may not the last fix)
> [2] https://lore.kernel.org/20260323150544.81042-1-sj@kernel.org


Thanks,
SJ

[...]
