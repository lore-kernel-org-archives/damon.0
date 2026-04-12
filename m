Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8C9AD4B
	for <damon@lists.linux.dev>; Sun, 12 Apr 2026 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776029848; cv=none; b=D7le9PbYDgHKXL82DAM0AxtUm4syJ1yajX+RY9fxjAlH+YhbOQEokFt/MwnZSroQnBbyhc9EigVEVUGHfNEihlzujyEZPMwBIc9e/Eu9ykA/QcgMX4KSydg57msXR+R6COwCSar+oWiftrMWRLZdGTTfT1bxCu34ZZrN24pLArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776029848; c=relaxed/simple;
	bh=xVt5Bhefg7H894rjV3Pjcx/a+7sCpLUN5Kj1JbeDq3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IC7fqdSaDJS//XzA2YT78YQ67SGMqEEYwn3XgavJX4/6aDquyhJid8a6xD+dHSF6PaN0gpkU0WP4ATu4rtd+94lmPIZsA9rrM34gvyfC11uiS7DkQptWl4efnoeurjnDJVKPs/nDeaOm3fCmkJ5RJMyj2PI4AjvXoBat89NDmWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4JqhYPE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4JqhYPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259B2C19424;
	Sun, 12 Apr 2026 21:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776029848;
	bh=xVt5Bhefg7H894rjV3Pjcx/a+7sCpLUN5Kj1JbeDq3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4JqhYPE1W6SVq95v9wml59sFT3uDnbcCblooAg2YHv+6IWa9YtylnfZi9nx8bcX4
	 Ag3hff1pjFKdEAmTTIiNCYrdenGRVyGgjE1Ah/1Erf4R6xCiN1IMkhiNi+/S82L0vR
	 ytdn1w2OxyzC+3NNT1WSg3+OCmnqkltvMMk6UmIRyTJOBaLqxtWxqiXIpKD6sk8IDN
	 vd3NDipLLitfrh4Ul0dFyaI3xabkU6mQOEh83Cud0KsxHPJHiUyvXpYAmIPFqLguT9
	 z6R9NhhLG/rwbcYbS1E0DVFPDMXG6ciSRelm0yr3xZfouSvR3OV0pz6QHIerzoidyD
	 kwvW3io7ZakIA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Sun, 12 Apr 2026 14:37:19 -0700
Message-ID: <20260412213720.89145-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260412190455.6685-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,

On Mon, 13 Apr 2026 03:04:55 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SeongJae,
> 
> Thank you for your detailed explanation and for being patient with me. I
> sincerely apologize for the confusion and the extra workload my unclear
> communication has caused you. It was never my intention to hide context
> or game the system; I simply misjudged the priorities and failed to
> provide the full picture.
> 
> I want to continue contributing to DAMON. I truly enjoy working on it,
> and I'm grateful for the opportunity.

Thank you for your detailed explanations of the context.  Those all make sense
to me.  Also appreciate your will to continue the contributions. :)

[...]
> > Next Steps
> > ----------
> > 
> > So, what to do?  Please prioritize series B, if you still willing to do.  It is
> > ok to keep doing series A, but only as the minor user experience improvement.
> > Clearly explain the whole context you are aware of.  Don't Cc stable@ for
> > series A, as it is only an incomplete fix of it.  The fix of the one trigger
> > point is just a side effect.
> 
> Yes, I absolutely want to continue contributing to DAMON.
> 
> I realize most of this confusion came from me misinterpreting your words
> or making assumptions without asking. So this time, I want to be
> explicit:
> 1. I will remove the Cc stable@

Please also make the description of the patch clear.

> 2. Since you suggested prioritizing Series B, would you prefer me to
>    send a revised v5 of Series A now, or should I wait until Series B is
>    settled to avoid more noise in your inbox?

Please work in your pace :)  Pick whatever you willing to work first.

I'd like to avoid delaying series B too long, though.  The bug is not very
critical, but better to be fixed sooner than later.  If you have no enough
capacity, please feel free to hand it over to me.

> 3. I will focus on Series B starting now.

Sounds good.


Thanks,
SJ

[...]
