Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769CF80BF8
	for <damon@lists.linux.dev>; Thu, 31 Oct 2024 04:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730348336; cv=none; b=PSe4nsuxfU0q5WZ3kc4FetEmuwcNbH4VdK4HX9vcJ178tnQwB/tkUwsKuh0PF/qhNjNoyCDRylkm/DPdVHlOlIeKWd66PPjLX0yVk3FoFjryU9BzAv8YNs6CqwNbhEmEB74G6bSxcgtWfexnFQAZcXEaIWJRxq7otZFnzY8ZnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730348336; c=relaxed/simple;
	bh=p7/qBQ8pktHx0yeOjh32JpOwhlVU8aXRGj6y737FKuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPjRqCHtFfqLeiScPWPzacYSrtaeBYwBuqQxxozYcX6fQX+MtH+Rm4wdhifLk+Ivcu4vOa0/VChl79GhIflRUhbdmsGve2fNZWUCaxWO7dZo02EUU1uAK22VQKjix6pgPmcw6GkcMqT1Ujoo6dSXgNgQHaJWBfJSu5yZVkd+Uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNfQDJIV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNfQDJIV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c714cd9c8so5923905ad.0
        for <damon@lists.linux.dev>; Wed, 30 Oct 2024 21:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730348334; x=1730953134; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkVs1Y+CuMo3+Eh4nNB4M87+SHBReCgyWbkGailay5A=;
        b=RNfQDJIVJ50PitgwlB3kfHqfGXRmMhlomi9o7g/9hI7MbyQBrPdz/3y8lnv8s/NLzC
         6bx2UVCGXhIwjL/497Ovl7Vjypl7qeHBWyML2OSVfYWLdjagxjiJRGI48D77KJQKprBp
         DeIwevNFfI/WcnGGPI6NvXXNG/5x4OmSzIoLsFvizRZsAkWl/LNbjNycWmcAlgfJ0S0J
         Ix+VO71QLbL2VuPu+5X8f/sH+/NBwSPCWURftyE/G8O7F8/touMS/jWefadt2h47KGu5
         kupHHHxJVWQ2mI5iry4SERF/AGJmimtC4QZAQ/ssZbJH9ZsYz6bAeuIy9SIAzHSE0FFk
         JLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730348334; x=1730953134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkVs1Y+CuMo3+Eh4nNB4M87+SHBReCgyWbkGailay5A=;
        b=kMFUTb4Ziohmb4lNSsyaIslzD25YeiZ/wWiOtsSZ/uLgoth79twPJ5te0XsAjHjHTf
         BNNtX8m6FIp39W+DrOhz3CMMg2UJIc9qXFVCWT5J9a73ug3JsNKEfdtwQQANV9Jj5W6y
         pvhNifQkMiIwzaggxIJ/9ghnd+C7p+It1NX9xJVzPr8FJSMUEu+mHxvSCmUeFzezDlyb
         hx98vFuMxfPJsq2LwDb4AN+G2Qf8WRzLipF0Dl3/mpDYsuqBBIkoiMUYmEZd5Kp5YWrn
         9Va2jQz1xebk3R1sBW6SG/zocOlKJ/4wCEAczFKWj0OgWMwemKo5f+wCMXvj5+MpWtV9
         yVRA==
X-Gm-Message-State: AOJu0Yz37QE/p5hW7m46WRnm8ekwpgOnQ7UyXe1DZzO3ns3lKUgF5L7X
	nj9xlJIsFHfYNEfMXh5odb1ssEYUcSCnhwuuNVsqn4yQK0I1oXm3
X-Google-Smtp-Source: AGHT+IHFWV367wh2uPQdt2rqVSEtCofg8Ekol1GCNvYosDA5Ysjy9NbyROKs/diI534vGfb87lE+9A==
X-Received: by 2002:a17:902:f705:b0:205:2a59:a28c with SMTP id d9443c01a7336-210c687c61fmr217240305ad.1.1730348333529;
        Wed, 30 Oct 2024 21:18:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110571b5ebsm3212525ad.117.2024.10.30.21.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 21:18:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 30 Oct 2024 21:18:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: avoid overflow in
 damon_feed_loop_next_input()
Message-ID: <4dd8ba2c-e994-417d-baa9-47e40b50c1b4@roeck-us.net>
References: <20240905172405.46995-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905172405.46995-1-sj@kernel.org>

On Thu, Sep 05, 2024 at 10:24:05AM -0700, SeongJae Park wrote:
> damon_feed_loop_next_input() is fragile to overflows.  Rewrite code to
> avoid overflows.  This is not yet well tested on 32bit archs.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/944f3d5b-9177-48e7-8ec9-7f1331a3fea3@roeck-us.net
> Fixes: 9294a037c015 ("mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> As mentioned on the commit message, this is not yet sufficiently tested
> on 32bit machines.  That's why this is RFC.

Is that patch going anywhere ? I have been testing it on a lot of 32-bit architectures,
and I do not see any failures.

Guenter
