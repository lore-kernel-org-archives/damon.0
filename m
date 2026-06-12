Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDBF3F44E4;
	Fri, 12 Jun 2026 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284143; cv=none; b=lrf517eVSucW4g5nvOfkeKBecosNPz6qS9L+sfe1O14D/oO7zRWwb7830O4i0J4GZ6dgJ0qyh5LrnSETokDfwpcxVp6Kd7cWRQ1ozS0JZoHdsDUYSKtOErmwqFBGK9pvl0YqA/+ruw13QrvnmP8UCoCAjLEBKOKHIqr5HZO8Ev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284143; c=relaxed/simple;
	bh=7d41YRMa4Rf7SsehB3A8aFwHAWiwjjEy1l8em50ck8I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ALIQMagl6qCiRVkdSwA5wnYdcXN3ilKvhEStZQ9o7j4rMX3C9VGa/YVnE86cZN883L2YpYFXOGGG/uBaXICqQYTlvlG1mD+96ExKPzeP69Iby9TQLhf8gJyjkx309l5P74ykOq0YpRBAMiIclVA9VQjgVXqTexqxoMwBlpBARVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bquUaG7N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h7tMjQUf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bquUaG7N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h7tMjQUf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B910B7A0148;
	Fri, 12 Jun 2026 13:09:00 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 12 Jun 2026 13:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781284140;
	 x=1781370540; bh=BsUebY2ZXG2/1TO6nMs7fw5YQPjV9f9LK+DvZ2Jcfhc=; b=
	bquUaG7N6CdRZXhDzy7S2dRUm3jRKQ6L0LVoYqkHU18Jsg+ri8+8fMM9WBcV59QS
	i9APzzg6XUH+ShtlW4AsiannDhuZJ14zoqwCo73/Y2bbkTT4Rcj7IBdww+LLqlK0
	iZKwd4aHvsf7zOVZ0rQAJISYcuxal3Fgkl8nsDeufvTG3wQWz+39aIp/2/FlV/eE
	3MxTRnS3litp11LMo5H3BheN8HK7cqqF9OuMPbPlzqoO3oO0IasFqrqN6mjNaDDk
	cGLgV/M/GmLaqLYXevN0U6OVDg4zwdQdc8NwrwoNRDlO3fQ6Tyvmv7kzRaEeNpck
	adtQKZ7CdSDxgruVrfcC7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781284140; x=
	1781370540; bh=BsUebY2ZXG2/1TO6nMs7fw5YQPjV9f9LK+DvZ2Jcfhc=; b=h
	7tMjQUfH6zFenuqIJLzxcK8xG12he/XQo/ImA7umOkc7zWoHMHGQUt3rVGYHoMwp
	wm9u1hlU8l2pYVim7SJ9vYZhGazTpcNR8wv6ceK7lRQwF+VcGmDzLFd8dFOhFSE/
	0dVpcN8a3D61vz8AdEW5aySTV4lNedqYb2EdiaB8qxS9Pv/3R+tI8Ef6y31f7vwl
	K9D20UqCCUjOMsdhtBINfiAgiXFp2lFnOsRvXgpiLGRpyHYeLcKqkhpwRwQSvZGA
	TF/b1iOCV5CXHounvY+w4N/bLWd3kOh3K+7jz3yHq1jmkrKuq7FyQH17Pk5Z60Jd
	S3QXsJBkecf3jfEyCAtBg==
X-ME-Sender: <xms:LD0savSXV5zl7_--zguKxhEvrbskKYlLVyRh2YvonnF6JXtbsVKxDA>
    <xme:LD0sarm-T8yPsQ9D2k4e0rQ4JW-wM7iUX4sMEzQmdxVH5_AAnurErA0s8FlZTDeFZ
    iI8dbT02OthdSpl3KG0PJLDaW2IA-QSsl2cHrLosTGXuO1HU6pZI08>
X-ME-Proxy-Cause: dmFkZTGwN+Ekeu17sMdaw9gASWSWOK9O1Zv6WScOHNDncCF07cLZEt8u3bD6JKiw70vsW5
    gyk4kNWrdtL4pFHt07VYa6ueq6AfuzMpNyJ5O/P61NOVpiIvmo2U75TLSN99ln+iUsMfeT
    mgxfr/nnyD5cckfWtpP3S42fIi/P2HV2KeFHQ47GGDTQWmoiCQywJ8H363tWJL16Zl1fhN
    fb84euBh50u7OJWWBPMoLhu4+OmzW0j/ZBELvHtbvROJbDewuf2x9ahVLaozXAbI74QsvL
    zGZK13k7Bj4cs+KCYq0u3ZGZdxwxfm6vDeOwboaoxEthvVrFdLmfecq7s7WWTejbwVaLGf
    ezclml10ERX/lJf3eMC0WO0XNyiJQqPghg4DbRV0EcAq8g2lXR5kF6Yn0CUwmd1qt0zj3X
    3wa1gWO/TGp4nqUp2PwtS87zJMSIwL5rnsLR+ZZg9hNk2qfuFc3sxnzLBki4MwOby9gWjZ
    XV37tWK6+dn4i9Y5eZ6uQ34q9R66N+0x6Mjxqco7ZNUw5xfbCQkLBrW++b0wZHE3W1pfn4
    f+xIsywnQUfzSyAyeTs0iQs4DiH3sDOIYehHPJ7lYjcNrdb0h8kH3bsD/CeGEKUNcaFTlS
    46j7JHCRXozPG96KAmNLdMoqPFCehFKzOK3MRAm7NMl5+YZfkJ+NkFcaolgQ
X-ME-Proxy: <xmx:LD0sahge6lPQ79-hlA-9zGwO2GZJyrDa4q9E7theuP66Ew4vx02gZw>
    <xmx:LD0saibguOBbn3ns75KWJl9c3Fg-yLHDdGyT2TKZ7v9xPspm9HcLoA>
    <xmx:LD0salgl3aExGE88O73YuF1R5qlx6JND46UvRasxbZ3CHi8iQYVnBw>
    <xmx:LD0sakYLC9-VHquBVHNSb-Mmbo9fR-lH6_HUc9pVqqoPcdFYT_cq0g>
    <xmx:LD0samHrYOlInMhF4Q8G40pcZfTTr6pnRcyJHmsiR1PTshu6yYKfN8gF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EF0C31820082; Fri, 12 Jun 2026 13:08:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AzfP_w-3vYjw
Date: Fri, 12 Jun 2026 19:08:39 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Laight" <david.laight.linux@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "SeongJae Park" <sj@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>,
 "Quanmin Yan" <yanquanmin1@huawei.com>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <139b11c0-dce8-4995-8f28-320dfd6cc70f@app.fastmail.com>
In-Reply-To: <20260611195037.1adec04d@pumpkin>
References: <20260611125704.3386176-1-arnd@kernel.org>
 <20260611195037.1adec04d@pumpkin>
Subject: Re: [PATCH] mm/damon/core: reduce kernel stack usage
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 11, 2026, at 20:50, David Laight wrote:
> On Thu, 11 Jun 2026 14:56:57 +0200
> Arnd Bergmann <arnd@kernel.org> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The main thread function has recently grown to the point of
>> exceeding stack frame size warning limits in some configurations.
>> This is what I hit on s390 with clang and CONFIG_KASAN:
>> 
>> mm/damon/core.c:3440:31: error: stack frame size (1352) exceeds limit (1280) in 'kdamond_fn' [-Werror,-Wframe-larger-than]
>>  3440 | static int kdamond_fn(struct damon_ctx *ctx)
>> 
>> The largest stack usage here is inside of the kdamond_tune_intervals(),
>> so by marking that one as noinline_for_stack, the functions individually
>> stay below the warning limit, though kdamond_fn() itself still uses
>> hundreds of kilobytes for some reason.
>
> Does that actually reduce the stack use if the functions are called?
> Or just stop the compiler bleating and running the code is still likely
> to overflow the stack.

The one code path that was identified by the compiler does not
improve, as the sum of the caller and the callee is still the
same. As far as I can tell, the stack usage in gcc is similar
in this code path, but it doesn't warn because the normal
inliner does not combine these two.

It does help in other leaf functions called by kdamond_fn() that
now don't have the kdamond_tune_intervals() variables on the
stack on top of their own ones, so in any other extern function
called indirectly by kdamond_fn, more stack space is available.

> I did that many many years ago for an embedded system (no indirect calls),
> the outcome was that we didn't have enough memory to allow for the worst
> case stack use!
> The deep places were all (the equivalent of) printk() in pretty
> impossible error paths.

Yes, that is a well known problem: it is very easy to construct
call chains that are possible in the kernel that go way beyond
any sensible size limit. Importantly, any GFP_KERNEL allocation
can end up in the file system reclaim path.

The -Wframe-larger-than= warnings are just one way to make
this less likely to happen.

     Arnd
