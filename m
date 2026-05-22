Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1E0274FE3;
	Fri, 22 May 2026 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779411475; cv=none; b=dXGztM2ji5kDBZThsUHciJGFgEPVRl4TGuMlwqbwZ3Tw6leKYtXcHeOrMBc91/G2MxTAolpmZh4D+ENy2mFXMGb/hcm6Z4Pc/LMbBG+wDmgBE8X55Jp2B//sxeTFdLAtKOgj+9xovnTTRY/svLCUIBTBVZXeq8F/hua2pvvhRb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779411475; c=relaxed/simple;
	bh=MtuIqSGtqS4UXsr8W1ACChk9kvm23dgfI8kEzf+fA/A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mPQYYyOncNFezqp6GiiHp6NEPCO1KUgM8edPwVQHA9pbrOnv6do1K9srPAQrqhY+zNMD4oJ18LSorEg2nLkGTJqFo/cjRGB6FqLmzpJsW2E58H/NCeBLU4zRYpoBVPvxtd0qKf1wHj6HVGqlNIiT9u/9I7hogDGX341J2IinHyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GLFqsSlv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GLFqsSlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B136B1F000E9;
	Fri, 22 May 2026 00:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779411474;
	bh=fwUYo0zI2vSQiwfY3hlowk3OeV3gQXWwuYQbo44sx+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GLFqsSlv76JXr7aoo+Q+pAlwRISlMiA1Pf1vnZceSOmAV/8QHj6cYJyLiLf2fdcVk
	 J+MQxyvS/v7PDlzNMGLZhG8yrTNAnqnUMLvaBj1EiRvDTDIWIQ2vMplk7Val/SzuMY
	 ZCsLy2/KvALt3xQkPBEMcBqu2IjhcsGSdxzuO+ck=
Date: Thu, 21 May 2026 17:57:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, David Hildenbrand
 <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes
 <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 damon@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RESEND 0/3] mm/damon: reposting three reviewed patches
Message-Id: <20260521175753.3c6369dd3fdb52ea3816ff2b@linux-foundation.org>
In-Reply-To: <20260520012104.93602-1-sj@kernel.org>
References: <20260520012104.93602-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 18:20:58 -0700 SeongJae Park <sj@kernel.org> wrote:

> Subject: [PATCH RESEND 0/3] mm/damon: reposting three reviewed patches
> 
> ...
>
> This series reposts patches that were reviewed by the DAMON maintainer
> but not yet added to mm-new, for more visibility.  From their last
> posted versions, only minor changes including commit subject update,
> Reviewed-by: and Acked-by: tags collection, and rebasing to latest
> mm-new were made by the DAMON maintainer.

fwiw, I don't think the Subject or the text are appropriate/useful for
the long-term upstream kernel record.  It's all short-term
development-time info which is best kept below the "---" separator and
discarded for the permanent record.

I rewrote the Subject: to "mm/damon: documentation and comment fixes"
and left the [0/N] cover-leter empty.


