Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57B539B95B;
	Thu, 26 Mar 2026 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528154; cv=none; b=TDo+JQq/jv8c+qVTgtttmnE51l6YQSJWUCLiD0NhZPzN7aLbdVdWJL6mai3GaTPN2HHKt89hOHvIOpNcbnsFcE3AE/ysEBhwqER9AOCNacd1oFehErjAVJyzpeoopylCI/Yk7dIliY4LXmvm13e7sCKMMWp5+CCsZ6NMIjd+MXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528154; c=relaxed/simple;
	bh=MHQo2d6U6dnT2K4Z4sQ9LVYx+GRJP5LTDe0a0UuxG6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9pHJ/Esm6tgP/6vwuTY9Xk4Yh4shhNJpF6/tflbzW8Mn+GgpTsatu58SsEJrPi073zvjoDVnq5p6Kzq1e9lJ24GO4uMhJugdh8iP43fV15uV3QUKl2drjbhjM3EB/f5phJMyMrm9t7rcxH+2CNrD/t6nvRtH0E3NuB2ChCnC2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lViYXTLs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lViYXTLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE70C116C6;
	Thu, 26 Mar 2026 12:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774528154;
	bh=MHQo2d6U6dnT2K4Z4sQ9LVYx+GRJP5LTDe0a0UuxG6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lViYXTLsqRu3Jc8wzyhmTZ5k5+60c0IW5OAeqZGUFl9nVp/UqWPsWrjb6SOm7dlrf
	 o1bH6m4Jx4eRmA5S7/8WYIe+b5c2qYtfJHVo363ORZyOFvWok5PMxuOr+FvqacktfV
	 MgvdX254htnWfi3MHldjJEGhp4ggMat6Qn7NfZrzFhAlSd8wmR/3fOclxOWDk5L4fA
	 grW9HhZ0BCHG/xBw6eK2996LSpmv2VUj3h4+ulAvmcQmdkvnCKckIWK2XRg8Mx3FvT
	 5I+zGjOJtjhqo15Mp9YP0l0kn0HtV4B0ttMlCYsi1ek1wQz/2J1G2xYKbYpKOBTUNT
	 uho4lWZZCwnGA==
Date: Thu, 26 Mar 2026 12:29:09 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Josh Law <objecting@objecting.org>, Josh Law <hlcj1234567@gmail.com>, 
	SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] mm/damon: introduce DAMON-based NUMA memory tiering
 module
Message-ID: <ae7dc7de-966e-4e04-bb55-318d97c61909@lucifer.local>
References: <20260326072737.341964-1-objecting@objecting.org>
 <cbd0aafa-bd45-4f4d-a2dd-440473657dba@lucifer.local>
 <b2cdda38-1007-41a7-a992-de953a088a08@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2cdda38-1007-41a7-a992-de953a088a08@kernel.org>

(+cc Christian as referencing his post)

On Thu, Mar 26, 2026 at 01:12:03PM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2026 11:34, Lorenzo Stoakes (Oracle) wrote:
>
> Trimming context, I agree with everything said by Lorenzo, very detailed
> analysis.

Thanks!

[snip]

>
> This patch also targets NUMA which is quite unpopular setup for
> hobbyist. I don't have any NUMA around me for years... Even my build
> machines are not NUMA. How did you get one as a hobbyist?
>
> Also after looking at the code style in this patch, after "reviews" [1]
> and "acks" [2] (quotes on purpose) this account gave on various patches,
> let's look what was admitted 3 weeks ago:
>
> https://lore.kernel.org/all/f8772114-a495-409b-a590-a9b1d8ed1d41@gmail.com/
>
> > I'm learning this Linux system day by day
>
> So learning or adding serious code for MM for NUMA machines?
>
> > I own this device ...
>
> This is about Xilinx AXIS FIFO which is an FPGA IP core. No way you have
> it. It's not popular, no easy way to get it in common embedded boards.
>
> Even assuming if you have embedded FPGA device and work on it, the jump
> from embedded to NUMA is just stunning.
>
> Answering to reviewers with whatever confirmation they look for is also
> a warning sign of non-trustworthy behavior. Or rather behavior trying to
> get trust.
>
> [1]
> https://lore.kernel.org/all/D47F8215-FD08-45ED-AB01-0A5C48CD41DD@objecting.org/
>
> [2]
> https://lore.kernel.org/all/2F84DD09-2880-45E0-AA98-204F10848F85@objecting.org/
>
> Best regards,
> Krzysztof

Yeah this is really adding up to somebody abusing the kernel process. I think
'Josh Law' or any other pseudonym that can be traced back to whoever's behind
this should be banned from the mailing list altogether.

Also, as per Christian ([3]), it seems this guy was using the pseudonym
"techyguyperplexable".

There's a github with the same name ([4]), and that same user made a comment on an
openclaw issue relating to linking it to gemini ([5]).

So it seems likely he/she is likely using openclaw to fully automate this 'Josh
Law' user and we're speaking to a bot here.

(Screenshots have been taken for the (possibly inevitable) deleting that will
happen later.)

[3]:https://lore.kernel.org/all/20260313-halskette-annahme-94e782eb4ae4@brauner/
[4]:https://github.com/techyguyperplexable
[5]:https://github.com/openclaw/openclaw/issues/44134#issuecomment-4106247302

Cheers, Lorenzo
