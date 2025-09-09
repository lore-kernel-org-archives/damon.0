Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51D23D29F;
	Tue,  9 Sep 2025 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757385349; cv=none; b=SsJlUjXXmonfgahOXqdL7S8ZGyEEvpPaosoeZBBlNZYEsHCEBE1d6MJKgTHmAKInxWlDeRo0Kpbq/BjQbubv+1kgz35v4BBaJ5DYWY7VOQqxKSDyx1L64tmb4e+HhmA0FWNRfcaA27xUSBNnXUzb8bK+Ne8oJRTP8hEpyxmf3E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757385349; c=relaxed/simple;
	bh=cZfhit3GglnSzityCsrp1a+znZusyvIgBXCsdOzHIjk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FgwM0nmELGKkzmXVC+Jxap+wlR0nanzjUjT0aJF/RhYyVy0YxetN2INHJ6+3DJpshRcPOZtbJmkvPERuMVtQCE3NPfaUnS1CKwmkSqk65Y97/CKqePRXgaXplj7meaK6YWJJ2wiJ5MTsL6CBTZ5bhiwLzKpSuNL3dLFarAnQ47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GD/hCEEp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GD/hCEEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A124FC4CEF1;
	Tue,  9 Sep 2025 02:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757385348;
	bh=cZfhit3GglnSzityCsrp1a+znZusyvIgBXCsdOzHIjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GD/hCEEp1s2INnkmtrSAcc+zYBtJH/pBF3LTNFDTrsZ0R+g/QXl6aJtMiG/Qp4IPB
	 4J8iWMfZwt5ezrsBu79fw2bzRLZgle5UHb6evyvUzMionuuQHZkPpVkLgGMIWsNapm
	 id94aOdJixFJ4SMt1hB5LoHQPf2wBHWTfBKd/H7o=
Date: Mon, 8 Sep 2025 19:35:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 17-rc1" <stable@vger.kernel.org>, damon@lists.linux.dev,
 kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] samples/damon: fix boot time enable handling fixup
 merge mistakes
Message-Id: <20250908193548.a153ef39d85cc54816950f71@linux-foundation.org>
In-Reply-To: <20250909022238.2989-1-sj@kernel.org>
References: <20250909022238.2989-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 19:22:35 -0700 SeongJae Park <sj@kernel.org> wrote:

> First three patches of the patch series "mm/damon: fix misc bugs in
> DAMON modules" [1] was trying to fix boot time DAMON sample modules
> enabling issues by avoiding starting DAMON before the module
> initialization phase.  However, probably by a mistake during a merge,
> only half of the change is merged, and the part for avoiding the
> starting of DAMON before the module initialized is missed.  So the
> problem is not solved.  Fix those.
> 
> Note that the broken commits are merged into 6.17-rc1, but also
> backported to relevant stable kernels.  So this series also need to be
> merged into the stable kernels.  Hence Cc-ing stable@.

That's unfortunate, but the about doesn't actually tell us what this
series does.  

> [1] https://lore.kernel.org/20250706193207.39810-1-sj@kernel.org

Presumably it's in there somewhere?
