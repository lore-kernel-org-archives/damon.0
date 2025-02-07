Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB741BC07B
	for <damon@lists.linux.dev>; Fri,  7 Feb 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738952532; cv=none; b=YEjG4hR2ya9bnG/6ktZ9k5ct6tYYO1OdJWPZL/oNCwe7x6sOKG8MlF+YLI1/d4vyNuPVrQlnTgky/69hJ5iYpAjjxofhrP9M1xjP4qviwTZEhstMCHOotU8C48qHTsjahxeeqZRxjO8izntX7q+/EQXf1wHPh4wZmMp01OiOGAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738952532; c=relaxed/simple;
	bh=UjIreNLQrW+cKC+ebyLFUis2qa7u5DdWOYELP238HmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaZg31U/v1ancfvTLjOJPfV8H4ftGZQoq3FTSlRikOimXtZu08XstbjFH5gVa8mSwZ/7cCvm579zDBbGgl+wQwivsz58BNjBkwAHJ55JAlqA7gdW/BZXk+JpFglNYjFXZmnqOZfePMF3OoFHXna5lapbG5cAzWzaRc02Hxm6lhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2ENyV+F; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2ENyV+F"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dc1dfd9f2so1286619f8f.3
        for <damon@lists.linux.dev>; Fri, 07 Feb 2025 10:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738952525; x=1739557325; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+YGX1DTK4BSkbmjULQJUOSzdL9bhIcw7veskFtned4=;
        b=C2ENyV+Fj0LX35WT9As5hoXV5K4WM8v+6kkrhGWylUZKanNnxUBCc+PP1dREesMV7n
         3iqgWKphTLBIJMBH+oflHhCJym62IDsCIVX8SkPRQSewkVJIwdwwqireBRqxioZzdSeO
         lfW9qQIN30siiYIPEmyaTu/nEvAc2p8/njmIGfRqwpGewEdUKYQbKseO9Tasb/WG34yv
         NUceBJ/H7L9EUzqWk+LnMCoG+yHwfsD8vWDM+KU51sx5CWsIH+Uwyx33aorYfJ4XMebu
         Kqf+HnmyZ6Th4e2eJC8/WcELbDiEbI50BUw+Kb2tSqyg6laKzXQW65Hq3sLjT46WlvW/
         De0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738952525; x=1739557325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+YGX1DTK4BSkbmjULQJUOSzdL9bhIcw7veskFtned4=;
        b=haGlGv9U35Dyt/7fddPQmZQa+Hn6k6j7UYYHBsUKMwbUpkyG5aQLwFeF9gvXIXeTl1
         AJKNbV9H6marIxxP7a8DFf3UjDzRhPn4auIMf2/sr/kmkfdxXRcUeYWg6YXnK+6z0drQ
         4WJnSiNLUL9Npy0VcsUNI9oldIY2WmTV6Milvi7KoyaWZjl4aqR2gaczhoTMtUqyLc9k
         73hFEJ8HJAGTaaThMoYiIRx1JXB6FyCXZ5EZr+Fd1d6gJv8DGM3+zO5sAKhhywxrzeOx
         6eFqoXUMMAPeG4xv9tcZZ5qwtDkGoL+d9vGKa/ywEpVPVuzaKjk/EcIYIc0CPBXGj0Eb
         F6fw==
X-Forwarded-Encrypted: i=1; AJvYcCUXy41friNgCGCgD3pYy2S/cK8kZ/FAqcCTzgEU8c0EHyorJJRdGSN0dp6VAUTq7t2uhw6x/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzVZshMn1GmVu+zRbe/KK/43hdEuSfSEHGfFoZz/tzY7+LrAp3
	hR0Lm0AKShBYVQtKhlEeSlPtwnlD0MFfFtLQszzywExyDbcjYzxsh+A4QQ==
X-Gm-Gg: ASbGncuOty/A3i2W5OE8wR6NwfbKawgTRjYmKRC+k6kLY+8DSGbch0nfCAZ79ZbL01R
	R5SPh1t8gGCem+WV6oHsXALypDmSB2eMI03VpRWWzfRfvEOHk512TIqqkjaleGFubv+CWCq3qAn
	CkEm1izVfyTeQIPW4SnBELSu/3AldKikAedcoOcUYAhJYW+WVXzShnL+qSKhSUqUykGZYu/c7Pb
	xtobPkTndsNCJSndOrLZpEXdfNZSa0dQF7cpeHbulaRFvV4pw2Z7Zie3YDSzatGrU9DtWjrnexG
	XmIFGzjl0N7pIa6vGonzYiTgdh8tDEgQbPHfe0aj25zIT/5hWa8Nbq36Ot4y2zHHYTxdOiJNNUZ
	8ATbYu7aqTrgUNg==
X-Google-Smtp-Source: AGHT+IHX6rf5djK8JZZYNxsUJ2jiy0jGXj+xlR6Spwo29YcCOu4YWtI8TcXWQg2JmgngQcGzngpIew==
X-Received: by 2002:a5d:64a3:0:b0:38d:cf33:31c6 with SMTP id ffacd0b85a97d-38dcf3336e9mr1574931f8f.50.1738952525138;
        Fri, 07 Feb 2025 10:22:05 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc4458d71sm4072564f8f.63.2025.02.07.10.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 10:22:04 -0800 (PST)
Message-ID: <cea1e84c-70da-4bb1-a35c-f7d0fc8d0ee6@gmail.com>
Date: Fri, 7 Feb 2025 18:22:04 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm/damon: introduce DAMOS filter type hugepage
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 hannes@cmpxchg.org, david@redhat.com, kernel-team@meta.com
References: <20250204231248.2729-1-sj@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250204231248.2729-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/02/2025 23:12, SeongJae Park wrote:
> On Mon,  3 Feb 2025 22:55:31 +0000 Usama Arif <usamaarif642@gmail.com> wrote:
> 
> 
>> +	case DAMOS_FILTER_TYPE_HUGEPAGE:
>> +		folio_sz = folio_size(folio);
>> +		matched = filter->folio_size.min <= folio_sz && folio_sz <= filter->folio_size.max;
> 
> We should also return 'false' if the folio is not a large folio (folio_sz ==
> PAGE_SIZE), if we agreed to my suggestion on the previous version of this patch
> series?
> 

Thanks SJ for the reviews.

I will address all of the changes in the next revision. The only thing over here is, I would
like the filter to work for folios of all sizes, even PAGE_SIZE. It would give us a more convenient
way of knowing if hot regions are mainly being backed by 4K pages, and improve observability.
Let me know if thats ok?


