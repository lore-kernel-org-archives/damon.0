Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2B4FDA6B
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016690; cv=none; b=VpEv7WSgW1iS9brAPlKhCsweQgK2nXP32vrXdHDXV7qfQVG8fbCsvuT51+470wwT8lSuWIJoBGW/+h5YXbhTa1mNNLSdX54CFQSwP6RxKvQEjFswuf5g+cLhg3o5dA9RTq4Vmj3gZQOKmA3fYzqTW18+JbQaTf1GEVCdEygXUm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016690; c=relaxed/simple;
	bh=gIA613t/TlSvmEDck9oaSUALamHs4wc+Ga8slxlZoho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGoagbHKYr0usuv5Y0vJlYU6IMvxb5iXUmqOc/+bDR9VbFCDbvUNMxEK8CvzfQBRamJstwV1vfKBTUNzydP/krOfqloGeqoo/jQRHXmcn5Ue+O8iY5MK57ClO4+oOyK9JrkGgb7Ug2lI/fXB00Ili1dRXIbUT915JOPtL0RhO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkUUrQfJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkUUrQfJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b91369d18so25345465e9.0
        for <damon@lists.linux.dev>; Mon, 21 Sep 2026 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790016687; x=1790621487; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tE3Tr4gm4tvb6Rbj5+pcpfeQlxZsP6Od7O86P+CMJdo=;
        b=AkUUrQfJeHxD1YKU6RL/EUHBQQHAiIMYjAVVjM3vqoZvGt047PxLqTddOD/g6+nyXd
         ZlK+ob0jAi9B1jNNBIiFVaZWbUlKLS1m6YDfTHLwsNEmW/DB+7Cwbi15ZyLOSVe6cAGK
         2Be2xUZbXQdRJvVuGjA/VuX6If01uWF+efqoscpPkKAizLWsYkxfee6pQUtabMpTOsjQ
         sjimup2c1ZgLd6DBABARiOPWiwntXGfDdy4F+TrKfGXEBcCvhbrpR5kYmNI0hyE7Wcrn
         3Z8ZdVWzsgeeCtnYadKS6jfI814iRh2z7NLzGwgh8uSlsVvowPXyA3E8kJTxhX5+dqR7
         b+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790016687; x=1790621487;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tE3Tr4gm4tvb6Rbj5+pcpfeQlxZsP6Od7O86P+CMJdo=;
        b=d9UdxddZ/iLCNuqEl1N5kjwsd80xsFH0hlsqh4qaWf15QTK1QL0moesgOLyXs9g5dm
         8xQl8tikxTh50V6TSAm3j0g2MCi0/i0Ki/3b4+qeuvK1iROUB9Xn/RIceF6kNq1EtGgs
         xXqvhjz2Jy46SqTHorPbz4Sjs8quPKwUZesisRezpK34kRm42xFv5L3538ST7DTDKzh9
         vqmqLdsoHwa/obu8viBNCyYiLwwQEZvUTRySPYGn4S5iZ1T6nsyPojRDZn8ANsZFp8kN
         FNUufHcJFTCv77+fE4s+jGPHRukEo3CEGe+VXMkEsJY1jSpRWnvcIAGhJPx+WzElw096
         HgXA==
X-Forwarded-Encrypted: i=1; AKwUvBw8NYSPjcprrjzRGEHm4IHnIQkPe6Xw1egGAxenP6iKePbJEHHsNuXKRJ0xqR3R+2CqZ0cJJg==@lists.linux.dev
X-Gm-Message-State: AFuF++nlrN6PDXEE70AHtrgxKglvEk+AkiJTaN4Fyh7FSyCn56f8oWsm
	hlPo/JNnGitIP7/60zKAIHQDMt2wI/5mMxg7amni2Ajr3QeMPE2R2PTt
X-Gm-Gg: AYBFou2NvHWcB1NrK3LnOjjzFHgtFsRGEjBavES2OpCNb4l70aq0x9HaKmSYmxncU0v
	bsptBHCBvnycU+lp+xbq4DYelcObYd4KetKc/1uLm+Wcv7iKujpz4IyTnhdikSNG09qBrZBitQL
	LO3e7fcA71QT+5GuRZacxQwX8oPZgTlMNSjHeRV6SsmXtVSQbA5KC9d6cFYeHsjzVyd+n33ZaLx
	IXkYIw01As709g/924yNg1SGvO4ePbdEFrZT26IOGWhN8SBx3q58pgdxGzoOWu4tEWX39x4hajf
	AO+2Z+ph9Q7863BcEghz9ZDJ5pGK2ny7kJOCkba+0XwUjs2NUU5bLYZmV31k+4ONATV9c17TWQP
	/vmRdne804MqAlqWnM8YJYqZoisoHi3/0T04zA6Q+oPVkJh4onNM2FRWBGX8n1Aux4I9LwQej/x
	OzE3+VCyetXQLbABVt1ey2BhNuzTAHvUK4Hn1wcXYGE9Ra5o8srmqdGaE1AjBjF2RM0Jn9diuKI
	AANZ0jSOYicTv/VO1dvvhVxSACWCpUgvMcn5hpPuwyxpyVEv8YR9xAUzKid65FL1R6KqGg/KbGg
	setVIyvUt4K3SOo26D/w/P0B2c4E2z2mGX7cqAJOKfUWfAdCfdNiZe2Lnzwl6yWiRoaEFyFHuoe
	+2ZJvrCZcEZ41Qdwlqth6HyI=
X-Received: by 2002:a05:600c:310d:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49fc5721b9dmr177099205e9.10.1790016686303;
        Mon, 21 Sep 2026 11:51:26 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a8e9-c501-45ee-6f60-3fc5-4072.310.pool.telefonica.de. [2a02:3100:a8e9:c501:45ee:6f60:3fc5:4072])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8b9fc5asm11550875e9.5.2026.09.21.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:51:25 -0700 (PDT)
Date: Mon, 21 Sep 2026 20:51:24 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: score an unmeasured PSI goal as not
 achieved for the temporal tuner
Message-ID: <arF7t_kmisrx0_WF@gmail.com>
References: <aq4g5W58PgWLqJ8p@gmail.com>
 <20260919155342.85699-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919155342.85699-1-sj@kernel.org>

On Sat, Sep 19, 2026 at 08:53:41AM +0100, SJ Park wrote:
> And the apply interval (or, next_apply_sis) is extended for each commit, in
> damon_set_attrs().  Hence, the problem can still happen.
> 

Thank you for explaining the apply interval. So the PSI measurement
period can exceed the quota reset interval.

> > full commit zeroes esz, esz_bp and the charge state of the running
> > schemes. Please correct me if I read this wrong. I can send a
> > separate patch for that.
> 
> I don't really understand the problem.  Could you please further elaborate?
> 

I posted this as a separate patch series with KUnit tests:

https://lore.kernel.org/r/20260921003047.12041-1-kmehltretter@gmail.com/

Thanks,
Karl
