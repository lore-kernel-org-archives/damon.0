Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2339C635
	for <damon@lists.linux.dev>; Fri, 17 Apr 2026 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434413; cv=none; b=WdWNQcu6IhEcYf2y+LwujeHOTRgWV/rpZm/2VhOs+q/eQWBerDhqJXZ23WZ/ah3/r41L6E7IxOXJa5wlRN0fjeOb+r0Sliq7uV+AX0ip3QqIBRHGp/hB/xDFPmGnV/6V7TY4JpdJnYYv/XBPlsbP7pwDK+NsCTKu6Ri5SR9q7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434413; c=relaxed/simple;
	bh=raaiP7xTUZt9W5HYdV3r9B+bLOKlUxJbEO+s7SeDAmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpbkQpe/bjlaVt5ButPngc+oh0ttKlEA9UYzO0ZbmGCIfqkVPPTGch+jBgle8fCAzUWzb2U/Gh3ODDEWI7OBBMoJrH7wkb2nTLUZJms7RdFtDi+oUntH4IUip/Scz+QmzsMbCR0r5535AK556bHqMdqjl+9rHuRGl9j1bbcTRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjWMdGUU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjWMdGUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA9CC19425;
	Fri, 17 Apr 2026 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776434413;
	bh=raaiP7xTUZt9W5HYdV3r9B+bLOKlUxJbEO+s7SeDAmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjWMdGUUNYk0TmEBlehXA6BS8dNfVhMFqczXF2N4onF+NGJAdUdkIA7LumxB1ifjg
	 D83CP65pYewn6ZJVUGd5WkCGUgem5+0tT0CuYh+JvRX3A/1Cw/Ym5dXwx2Usa+cZM1
	 61q/4EYsKPML44nYi/Vis7AUHSAKGwD0MGUEShsQq4uQvqYy5zxgHJI0k1FP83SxiY
	 KcQ8j14T6Cwg9kIBH8YlGnEL8WQtVdukR30QHSAQju+5UeS8X3v9736kiSkRw63WWN
	 v7NW86Ov5yQslnkhzM/pW14eIGTNXm3BCDf1U2Z2x3gZVXmBkMgN9ZXp4XKPX7hYsj
	 fuYgjobGY8ZPw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] mm/damon: reset thread status parameters upon kdamond termination
Date: Fri, 17 Apr 2026 07:00:05 -0700
Message-ID: <20260417140006.78938-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417042701.4077-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 17 Apr 2026 12:27:01 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Thu, 16 Apr 2026 18:12:28 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > Maybe I suggested too much...  If we decide to take both my suggested commit
> > description and the above change direction, maybe it is difficult to say you
> > are the main author who should be primarily responsible for any followup issues
> > on the patch.  Of course you will still deserve to have credits.  Maybe
> > 'Co-developed-by:'?
> 
> Yes, I've decide to adopt both your suggested commit description and the
> implementation. Therefore, since you've done the most of the work, you
> should be the main author of this patch.
> 
> > 
> > Meanwhile, I feel like the fix of this bug is taking bit unnecessarily long
> > time...
> 
> My apologies. I have had limited bandwidth recently.

That's not your fault!

> 
> > 
> > If you agree, hence, I'd like to take this over from this point, and finish up
> > the remaining works for this patch.  If you also agree, I will also take the
> > responsibility (authorship) from you, while keeping keep your credits with
> > 'Co-developed-by:' tag.  What do you think?
> 
> I agree to hand over this patch to you. Thank you for your help.

Thank you for generously accepting my suggestion, Liew.  I will do the
remaining works.

> 
> > 
> > By the way, I hope I'm not making you to get me wrong.  I'm not trying to steal
> > your credit (authorship).  In my opinion the authorship means the
> > responsibility (or, who to blame) more than the credit.  Putting right name to
> > the place for the responsibility is important for the long term maintenance and
> > evolvement of the community and the product (Linux) in my opinion, so I have to
> > say this.
> 
> Thank you for your explanation. I understand your point that authorship
> implies responsibility, and since most of the core ideas for this patch
> came from you, I fully agree that you should be the main author.

Again, appreciate generously understanding this.  Please don't forget there is
no change to your credit.  Without your contribution, the fix was impossible.


Thanks,
SJ

[...]
