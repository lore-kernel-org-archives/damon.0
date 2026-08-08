Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6B4B04B4;
	Sat,  8 Aug 2026 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206455; cv=none; b=DAL5KhsPvyAaqy0MbcxT/5XcgpNr4L53KdzNzBy/b9t7T03pk8gfSjSzaGnE3CreTmFgxComHiBDpiNlDZy4Xf86ZCLQXO5nH0bZe28R2n8RE10dTnzw7IYFQvZaCPqwuCLo/Ky9X17Jsr4Snh67BxbTFClodL1eUs70sMWKrk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206455; c=relaxed/simple;
	bh=io4nfNS3G6OpJ/uegcdKnelMT2OqjPPdjTRNH18vXwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCoSI+FCv9dZ9jr5W6Qi8b+SOX5CA/pPXPhkn4NqorjJMR6Wu1uHVQFzCtRxRRXlubfUTnalXeVyapkF6AjpcdLkc2f3RtP0vYPB7OYDkRL6hFWMe0kIX5NhbAgPYPAyj51NeUEHYoCN6wV02MwrOfDiezozuotSwwghA2HNr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB2Y8P6i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB2Y8P6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3165A1F000E9;
	Sat,  8 Aug 2026 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786206453;
	bh=Mknf88l59jYGHy564b6wquM7BKXv1lWu2LkHGwW/3nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oB2Y8P6i7M3KVb+6+Z/Z5LZP2H7EBd8xQolKqmDNfimo30AInQxzeSCHrVV6fZBwo
	 IYMeuwH9IrBM6jkBf5md5U2jScC8m2wMFnoXrZu4RtqXGhllFckDLG52VlutPStfJZ
	 U/ozrlktpwsAB4SHVxrU7AF79bqNUSwxvw/Lnf/67kHCYre1OkqCsW3tuvJrQoruQ6
	 yD0oj/l4tycXWRpos5wcFrVB8EIKfsDFoa0fJnYgmrQ1FiE5XHkuJct9wbgFq3V1IX
	 5y29rviBQ2m6OwmNW6/IU1RvMsJIkLIs0qgBpXWwYr5zijg/JId9jWiUJr7iz4CSlg
	 OH+jlUY5NxdVQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [CFP] DAMON Nanoconference (aka BoF) at LPC'26
Date: Sat,  8 Aug 2026 09:27:24 -0700
Message-ID: <20260808162724.92408-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806003357.92659-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  5 Aug 2026 17:33:57 -0700 SJ Park <sj@kernel.org> wrote:

> Hello community,
> 
> 
> We will have a DAMON BoF session [1] at LPC'26.  Because it is a BoF, I want to
> make it as casual as possible with many voices.  Hence inviting you.  You could
> think this as yet another version of our bi-weekly Beer/Coffee/Tea chat meeting
> series [2], or the first Nano-sized DAMON conference.
> 
> If you have any topics about DAMON that you want to present and discuss in the
> session, please send an email to me.
> 
> Example of topics include but not limited to:
> 
> - Your DAMON work that is recently landed, in progress/plan
> - Your DAMON usage and success/failure stories
> 
> Depending on the topic and number of proposals, I will try to give each topic
> 5-15 minutes.

We already got plenty number of proposals.  I'm closing the CFP.  Sorry for not
announcing an official proposal deadline in advance.  Please feel free to send
any DAMON topic, though.  We could extend the session to hallway track, evening
event or a later DAMON Beer/Coffee/Tea chat.  Also that will be helpful for
planning the next DAMON Conference.

> 
> 
> [1] https://lpc.events/event/20/contributions/2453/
> [2] https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ
