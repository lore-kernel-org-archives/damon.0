Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3069D131E49;
	Mon, 30 Mar 2026 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774849678; cv=none; b=gEEGvS+01GpYyAxGw4ETVJ0hhDVhUj9KJZ5OnEFeAiPbZvGgIt93XJkNQ2pqV8RjbYIaKWV2mZDS8VFartWRmaukJn7U+sWGnopwU7dH6EcFxSz7+R27Of+PF+FZamjAi1giJiZ9KvYs0b8IlPADJ+WzVqXNfUigNu7WiIQXTn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774849678; c=relaxed/simple;
	bh=qyDqUEOyuGKVWNwH/c11TUyv3guz+h7W/2xYEx83qdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7TLM+Kapzail2d1H7Cc6K00SYbfzlIxf+j2wkZUguj2nc2a0EPvsMg9XeN/Uh7odbPE/zfO/0wfa/DyaFDHHkjmQ2uZBR+I41VsvdNl7mBtEEu3qTBxtDMSKekpI4TndEVUCRJacCrPOADpViGJVk1mu1ZVLcDY6MfnnJe/bQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s6CxoxH0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s6CxoxH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F97C4CEF7;
	Mon, 30 Mar 2026 05:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774849678;
	bh=qyDqUEOyuGKVWNwH/c11TUyv3guz+h7W/2xYEx83qdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6CxoxH0HeeGjkoRHRYMsUCMx1bmeebfIP/QXjBDYhu3WBZcQ3seFDg7iH3ojeAsx
	 NwHNs5oe8IiLJHe8it1Exk6k4SJArLYUlsGy9Lap4JOq4U0kUr1qApjqCXRPo0fClg
	 /PzekReHjwvzt9G5P1YnFoF9TSvZqY3xrNKx1id0=
Date: Mon, 30 Mar 2026 07:47:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, damon@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: (sashiko status) [PATCH 0/2] Docs/admin-guide/mm/damon: warn
 commit_inputs vs other params race
Message-ID: <2026033013-drainage-stylized-43d6@gregkh>
References: <2026032915-library-embolism-b48c@gregkh>
 <20260329193226.59025-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329193226.59025-1-sj@kernel.org>

On Sun, Mar 29, 2026 at 12:32:26PM -0700, SeongJae Park wrote:
> + Roman for a case he has any opinion about my sashiko usage.
> 
> Hello Greg,
> 
> On Sun, 29 Mar 2026 20:05:53 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Sun, Mar 29, 2026 at 08:49:16AM -0700, SeongJae Park wrote:
> > > Forwarding sashiko.dev review status for this thread.
> > > 
> > > # review url: https://sashiko.dev/#/patchset/20260329153052.46657-1-sj@kernel.org
> > 
> > Why are you doing this?  If we want to see the review, can't we just go
> > and look at the tool itself?
> 
> We can.  But it is bit cumbersome to opening web browser and moving my focus to
> there.  Reading everything on the mailing tool is easier for some people like
> me.  Like some test bots send reports are replying to patches, or we sometimes
> forwarding bugzilla reports to mailing lists in a form of a plain text mail.

Sure, but are you going to now forward all random tool reviews that are
run on your subsystem to all of these lists (your distribution cc: is
quite large here)?

> Secondly, I have to share my opinions about the reviews, as many times AI
> reviews need human's opinions.  There is no good way to do that on the web ui
> of the tool (sashiko) for now, and I think this mail based flow is the best.

That is assuming that you can fix up the AI reviews, is that happening
here?

> And anyway I'm supposed to share at least my review of AI reviews, in mm
> community.  If I ignore, I will only make Andrew have to reply asking that.
> 
> I used to share only my review of the AI reviews as replies, instead of
> forwarding AI reviews and then replies to those.  But it was
> 1. cumbersome for me (should summarize AI review and then my review; feeling
>    doing work twice), and
> 2. feeling not optimal at sharing all concerning comments with others.  My
>    summary might miss some points of AI review but other reviewers might just
>    believe me and don't read the full review due to the additional web browser
>    opening work.  Also some other reivewers might kindly review AI reviews
>    before I do, and save my (or their) time.
> 
> Hence I ended up to do this bit odd workflow:  Forwarding the full AI review on
> the mailing list first, then reply my responses.
> 
> > sending it back to all of us feels odd,
> 
> If this is polluting your inbox and/or distract you, I'm so sorry for that.
> Please let me know if this is distracting you.  Maybe I can filtering people
> who don't want this kind of replies out of the recipients for the forwarding
> mails.  Or, if you have a suggestion about what need to be changed, please let
> me know.

It just seemed odd, and might get crazy over time if this happens for
all random AI tools that happen to be popping up now, right?  If this is
the "official" one for -mm, that's fine, but consider the distribution
and intended audience a bit please.

thanks,

greg k-h
