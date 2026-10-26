Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025904;
	b=CWTvbct38PwoM9Pld8cy2zB5bHxAxcWAdo7Y3MqSabTiLYnFp31ZpfG85+BLGbV8jBoc
	 uX8z9/bKKQMYIbm/YV6bnYR6bBnJ67AJESyxZnmbBw27aUkSOQLBtZdWZfMXKqaaXCD9I
	 p6H8sbMOlusOLsOUgnxWkWKNwRYOM7a4wB6IT9PUQK/MyT1l6F2i0h4gfz881L6Uqz1Eq
	 yg4EVEFU/Dq/NlpjqwHkPwuk+XoLJfAHBdWanTapt3CuLKIYgzh9i3l5MIJCLCDeqTDLH
	 bKOIA+9RlffinA6VTRgwpPR5dD3qFHW8oKLSmZnxZTrxe4A4GUELxU84lVKXHIUSdWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025904;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FT1RdVZKFn+emuIq4wyVAsdeeZxKAtKJ3BuQVSeNiXM=;
	b=1EZml10EK/Ahy7lmeAI8wvnWhUKyXyYhb2DnB0gwSXhxo75/pwDkMdPa/BNY62RMWaTT
	 fF0K9P7rnGwv86oGBRn8TGKdjyxuEFXzMJ+z+XzIv8ZQTQ2bXisgjv7UqPcjamDrpWp6c
	 Bl50oSCz01gXizfXWKR9v5bbQM8eBnpD9hfEEPi7vhPWqcbMvtzadi0jijl1TNFAsAsjH
	 mv/SbuTRUdMrF6ydmkxc5s7Ae3Umn/y7HJXEPRgzSVT43Z7emRfWmqktGKm/uawxFKeSE
	 f5L6RgviK5zBQTvZskU3cTUtynrYP95G3VElR//89qU1SXBAqcjEcPOLOyOPKbfR+Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKutAHz3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008DA606A31D;
	Mon, 26 Oct 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKutAHz3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344B31F01829;
	Mon, 26 Oct 2026 14:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793025903;
	bh=FT1RdVZKFn+emuIq4wyVAsdeeZxKAtKJ3BuQVSeNiXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VKutAHz3mI7cYrCfwND0ANbGs1pVOCiHmR1hqXLQ8nqksJZqgRcOL5Iesy9WQ5C+q
	 ri1OfR+RVSMTC8uY4CxZmbCaWqINlZJZ7LTg5r94rRde0PBEStAxV96r2oVCvzDhcC
	 +5pW9w02Uh9QI4HgkPy9ufqM6+jC1JcsjswnufEtI3HmhT6hkGvxQBj6tXGB81GA4T
	 vEPVVuHMS+5kDWYWsKhjhgw+2hILYm43edDkdTCvNid1Fyp+p7U5bOjSUtaMOaahy2
	 6fv6utu6SXRQpiFABFMsYycZ/hFSwmXTPgySiwEDS86x5od+1cK7TOwHq/ctKPAGHt
	 nkPdwHkZfhQoA==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	Aveline Noir <jm5905938@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] Docs/admin-guide/mm/damon/lru_sort: fix remaining grammar
Date: Mon, 26 Oct 2026 07:44:50 -0700
Message-ID: <20261026144451.150560-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d054b7a2653a2ff3d419b689a50a53290c2cafbb.camel@mailbox.org>
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

On Mon, 26 Oct 2026 13:57:49 +0100 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Hi again,
> 
> On Mon, 2026-10-26 at 22:14 +1100, Aveline Noir wrote:
> > Manuel's recent grammar fix for this file, now in damon/next, covered a
> > good part of it.  This should take care of the few mistakes that are
> > left, like "should automatically activated" and "Make DAMON_LRU_SORT
> > reads".  Rewrap where the lines got too long.
> > 
> > Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> > ---
> >  .../admin-guide/mm/damon/lru_sort.rst         | 45 ++++++++++---------
> >  1 file changed, 23 insertions(+), 22 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
> > index aa4cc90ca57c..c628e3f6e587 100644
> > --- a/Documentation/admin-guide/mm/damon/lru_sort.rst
> > +++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
> > @@ -35,7 +35,7 @@ deprioritizing cold pages on their LRU-lists.  To avoid it consuming too much
> >  CPU for the prioritizations, a CPU time usage limit can be configured.  Under
> >  the limit, it prioritizes and deprioritizes more hot and cold pages first,
> >  respectively.  System administrators can also configure under what situation
> > -this scheme should automatically activated and deactivated with three memory
> > +this scheme should be automatically activated and deactivated with three memory
> 
> Yours isn't wrong but I would make it:
> +this scheme should automatically be activated and deactivated with three memory
> 
> Choose as you like.
> 
> >  pressure watermarks.
> >  
> >  Its default parameters for hotness/coldness thresholds and CPU quota limit are
> > @@ -55,7 +55,7 @@ DAMON_LRU_SORT utilizes module parameters.  That is, you can put
> >  ``damon_lru_sort.<parameter>=<value>`` on the kernel boot command line or write
> >  proper values to ``/sys/module/damon_lru_sort/parameters/<parameter>`` files.
> >  
> > -Below are the description of each parameter.
> > +Below is the description of each parameter.
> 
> My choice : 
> +Below are the descriptions of each parameter.
> 
> 
> >  ...
> Looks good to me.
> 
> > 
> >  --------------------
> > @@ -310,7 +311,7 @@ Total bytes of hot memory regions that were successfully LRU-sorted.
> >  nr_hot_quota_exceeds
> >  --------------------
> >  
> > -Number of times that the time quota limit for hot regions have exceeded.
> > +Number of times that the time quota limit for hot regions has been exceeded.
> 
> I would go for this, but I'm not sure:
> +Number of times that the time quota limit for hot regions have been exceeded.
> 
> Number of times that ... have been exceeded.

I have no strong opinion.  Aveline, let me know if you have some.

> 
> Thanks,
> Reviewed-by: Manuel Ebner <manuelebnerli@mailbox.org>

Thank you for review, Manuel.


Thanks,
SJ

[...]
