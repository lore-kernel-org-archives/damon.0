Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B5129B23E;
	Mon, 23 Jun 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696340; cv=none; b=XXDFhOT5KnvxGvShnLFHBXB+PcLbOs44szJQjMlaNxY6gxpHtfxGNPN+Fa3z9OEADHrw3MYVXcpEHYTPLsO0BzebQ795Bup/ZoyYD8Pms+StzLNFONDhlSsK9shLjhnliiutoEyzautXk/FSD0ydzj6kseSqOl4lzy8qBeNEzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696340; c=relaxed/simple;
	bh=c1X7juEAfPFJyjaQ2dW3jcLwq1NCy79mFr5ClLmV4Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jncGQSJ6Z51B1WHmoaaAvREBvKpFtyikgT5g+PzYDwgQ4NiIrbnVcZhbuGFmWOAsN7AprlajZLA1kysHJLCF8y83xVzY1DXvHnOM6LAM9GOJOtJstuEcuZD5qT8VEkLwSn4MT3HqVDgW1IzNoenjdCpWGNQhvikbJFvOWa9CnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFgpsTas; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFgpsTas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305B2C4CEEA;
	Mon, 23 Jun 2025 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750696339;
	bh=c1X7juEAfPFJyjaQ2dW3jcLwq1NCy79mFr5ClLmV4Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFgpsTasSqg1WzEPpW8ZmXLDXRFw9X8Hb7poFk8AAGOr3bWkdncyLWwKU8M15xtq2
	 /OumMWNwLKXPsaVeXq5qnHeS6jGPcWdmDywYRHEbPKngYIyxZXZspmm4T1V5nAx3FD
	 W/EuY+mayFNeOyJqSrFdMF67x/cUS1fpnBBv2gSJrJxhYFLRXNa3yF9/m/foOeA3PT
	 b7bPbrY63PVxXMgFpZC/3ktbcTfBsUOM429QgWsq4LCcHYLPWdtUIh3oTmkd4qTvwJ
	 XNG9fcgfZcYivraeoSFZCnWM+4uip0g6Jc4zuKEb5sBhgQUgYB1iz1iG9Zu4uRQtlC
	 U0EhKGySj/J7w==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 0/2] mm/damon/paddr: Allow interleaving in migrate_{hot,cold} actions
Date: Mon, 23 Jun 2025 09:32:16 -0700
Message-Id: <20250623163217.41814-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS6yuosvLxUn8+GnGJdqE2LnfGgur0x0hTM6nqmBpU-q9Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 23 Jun 2025 09:39:48 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> On Sat, Jun 21, 2025 at 12:36 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Fri, 20 Jun 2025 16:13:24 -0700 SeongJae Park <sj@kernel.org> wrote:
> >
> > > On Fri, 20 Jun 2025 16:47:26 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
[...]
> > I just posted an RFC for this:
> > https://lore.kernel.org/20250621173131.23917-1-sj@kernel.org
> >
> > Note that I didn't run exhaustive tests with it, so it may have silly bugs.  I
> > believe it could let you knwo what I'm thinking better than my cheap talks,
> > though ;)
> 
> I only skimmed through it, but this looks good to me, thanks for
> throwing this together! I'll probe more when I use these patches for
> the next revision.

Great, please feel free to add comments there.

> 
> I'll try to reply in that thread as well, but it was only sent to my
> work email. I'll try to set up my work Outlook client to work with the
> mailing list format,

I'm sorry to hear that.  I personally gave up working with my Outlook client
and using a tool named hkml[1].  I started developing it for my personal use
but now it is aimed to help contributors for DAMON and Linux kernel in general.
So, if you are interested, please feel free to try it and submit bug reports :)

> but in the future, could you also CC my personal
> email (bijan311@gmail.com)?

Sure, I will Cc your personal email together from next time.

> Gmail just makes formatting for the
> mailing list easier for me.

Right, Gmail is better than Outlook.  To me, hkml is even better than Gmail,
though ;)

[1] https://github.com/sjp38/hackermail


Thanks,
SJ

[...]
