Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E75B2D9EF3
	for <damon@lists.linux.dev>; Tue, 12 Aug 2025 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020147; cv=none; b=Y2VQotTaTemazdzIKBL+6rUZ7vcq4HY3gNoWqFS/xveL7YqycdaF3oW0KOe6oH/QSwHaN7NmxkxXaa43AAQrCfRkEq1LlJaVdlqak59c6bN7vAUH8faoUK7zeb9uAHoEePv55JFiTzjKnsttGeekCfQAKmZbQKU4lFU2GmlPuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020147; c=relaxed/simple;
	bh=/fk0SInUI+7YMulFy98YQ3QInCIqTEu3ouODgJVlNh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiXB1bUd+92r75N+PBR9vwRIrYUc6HjKo7C+0rn4Fwtko2W2e560C0Ih46Wjkk77TlV1oONH7e8j7tNqsl0IeFw1cY2TSkXed+36L2gGB0aE0chtoeQcvFdJ03aOKLIx1M4XSmcLrZF5xmidUKJy4PeD0EFg1T/PXlw3l8SRKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htPusJID; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htPusJID"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76bee58e01cso6819624b3a.1
        for <damon@lists.linux.dev>; Tue, 12 Aug 2025 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755020146; x=1755624946; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QqRiRc8S5UuRZr109N2LH3VeQOZ0mfRe2blg1ehQPc=;
        b=htPusJIDCcqusfrcbFxIBNSP8GQ7l/d/OpVsFoGHgQdz1yKLlg/0Sfqe1X2Us3zzRi
         qngiJuJEEd43hougKWDhUqGrBVDVf5sz8JvAp6F/t6bCMBV8TG+FqfR+NgeEyaLMCMxX
         s2+9Xdux0k67aHRwzYWpUHw4UhcF68GGJT3ZRtP/w/KMe+BiCvirBrdHfW0aFMCyBsbY
         t7SeJr+FUfNccJgkJgQ5AzzJW2CYZy4gdUoBIHqFWchbgI+WcPkY3xnwxGorhL0df9U2
         XdPTZQ3tkR5xPnRzzaReyf+1X9Uke1RS4xM6Wie/1xWB5oQTbkxpRpk8cQ5ixc5odJrP
         Tkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755020146; x=1755624946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QqRiRc8S5UuRZr109N2LH3VeQOZ0mfRe2blg1ehQPc=;
        b=Hch4oPh5c+H9kf+sfawTa2gD0v1V9q70ERdi29SInWXSUrrKUTigxv6Y88jC9Zpr7N
         L59oj0RwLyuH7V7BWtAekEzyJ4nx64z8IfeR4s+xAFdhEv+xOXWJDEq5At5tlUlV7jB9
         nUClXm6DR42tF56lkNwjFdQmG7o5ptUMNFUi1+R6hZzQpDZNMJser2d5+sqJANvXGa42
         C+qOVaMZJOu/PrSU9x4ectQ3fvaTwbIHy0sVe//Ef279DFjtE+7oSpiYMJpGAPHhh+3A
         gYirk7Pkb1Gd9v3CHwaT/mC3p7lZQRl9St42LKZsNc+a5XVYHI2B7ljPJGJqzvX50UN5
         ZQrw==
X-Forwarded-Encrypted: i=1; AJvYcCVyEbt0vFg+wDH5YP1xKnaBEwEQIrnSKcT0evdQ53hMCI6DbJCp5Z5BNr6mQKATLBAtC6S8rA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcN1UlLZsciceb3l6jj7GBT/d5EyA9EQZczx6KKTdzla6jeLOc
	SpMYyIyPYf4BU3G1yC01YbUzVdbrB8WbqIVfEwK3mjVdkdiDI6EsHq7v
X-Gm-Gg: ASbGncsk4ZLv3NxMjmiPnFWJpQlLloFVk4gQrnIWbk4FTkVlyUkqMkp0wlWkyOzGPuU
	avpOH2Ulsr3q4oqnA+BKlr6SfdteKpL8MZ30oPyBt+xVlRISF5CYRGx/KUQEC30cwc9VaLPq/qV
	JVUEtJtXCs4I8rTuvS1YQFKrYRTAX6ar1gPeAuRsGh1/UImNzktstHa7UgWu+KkVoYa+x75THyl
	9Fmx1gKf1/b7IPgnwh6GJC75ZHLgu6r1/m1eUitZ8OZobGucL3nBc6JOjsmK82AbvgtzShgSSyC
	2R0AvIAxXfxWMy179VlNu80h8ekJ++4YTmvX2gSaEYeOCeKfCeA/gjIKCoww2d/BldaynJUX5ib
	cnB55nl/ONfk5HbN6K/9smWY0T5UhqL2w8GVr5GKAGxnf7EAykUmObw==
X-Google-Smtp-Source: AGHT+IEOQGwikHmdxCwnSLSNmqiAKdWaAmIlOvX98dKTEa3j/V/1mLnNx7izZ8MziWVIRtrOO5jPPA==
X-Received: by 2002:a05:6a00:a17:b0:740:b5f9:287b with SMTP id d2e1a72fcca58-76e20c9a0f3mr83634b3a.1.1755020145514;
        Tue, 12 Aug 2025 10:35:45 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd9795200sm28297220b3a.114.2025.08.12.10.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:35:45 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:35:41 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mm: remove redundant __GFP_NOWARN
Message-ID: <aJt7bYkhuRBrIO_S@fedora>
References: <20250812135225.274316-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135225.274316-1-rongqianfeng@vivo.com>

On Tue, Aug 12, 2025 at 09:52:25PM +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> No functional changes.
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
