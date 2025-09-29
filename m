Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD45302CB9
	for <damon@lists.linux.dev>; Mon, 29 Sep 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146187; cv=none; b=gcWDkbmcej/dp9m3AORhZ8dSDwnESLXrhAwRlarCload1R6w+K9xPcNk6TkHeTNrjkWh+ArpiUxjngqN7iabadsNh27fqNorfydn/y7VgrIzL76OnPcW/leZ/WRLhbr+J0qusbOF8memhDKBOO5dXcYzFosJJLVpoLg0rRa3Xik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146187; c=relaxed/simple;
	bh=v33lLHmNhHgyven3UnpSjmdXiGRlpTjR/b+1VSj7xaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlqJUMy/goJ2J2YkbgNi3WxoP897Oi4y8IZNyUJMjsRs07pNO6pCTkc2g+QmK8ufavds+hYdwlb85tg/0eV7H1x9f6Xd1zjvOZS/w6Emi57MouimQlcNtvd/hbnyFovgJ1UOexkUKTfJmErhd++uNJyuu72/YXZ5NR8HE4QI45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2qu3mY2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2qu3mY2"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fc14af3fbso6341507a12.3
        for <damon@lists.linux.dev>; Mon, 29 Sep 2025 04:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759146184; x=1759750984; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mbjVJui29v4n+pWGfvI7ZRvpZGP8q8p7zkZRQub17I=;
        b=c2qu3mY2+9i36YjVO2P2Vq0UtIKN48//UtK/JxwvgMyhtAAc9AAB3q36h7emU56M/m
         11Dyspyfn3JqdPApUsSjpqRs0Np9J9Lbq8SGfNv/3XaMVWahd87GUU+CqAxBuIdi42mq
         GSgXfqX2RAHyXymbFAa44gXN1YcG75z11sLr7lNQRJvTTRqaK1CZFeDDLnoCnWjVffXn
         3PImQ9y9BgV2OGPtmBoZE/ZoYZKlzz5/+L1BeJdg0rmNSap6MsJeNbvFaldYOCWg/T/1
         gCnAQpITzuwHwWFhyrDL4jZUE6qwUzhntkffyOjm/u/ngvzS/xvtprJAkItQobgarcK7
         NxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759146184; x=1759750984;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mbjVJui29v4n+pWGfvI7ZRvpZGP8q8p7zkZRQub17I=;
        b=nQjvoqefzlFqfbxrNc9Jp2C/46Td1vOOZBhCgcF5PfHTLSh74imYfdMZS6hrV6xHmY
         yFwj5T+NxcsaHc0PSMwD0i+W7eHXh0bYYOtyX3rzfE/qWWzkqxEX2qZPxNLtaeU01D57
         uzePe7BbkyqkGeGmJyZoCc54rDTu25FWQ3pPIuPmr9qFX7R2KjC7layFklHdoDMuQPXo
         UMMFsby+ELxhCmMFUA1OiEasR4SrelgBP2jwY/KSoBYZCGOeguguUclrLGrYNW796JBx
         NPbpW12fyV0cdarkUPP/HEDQCCBX3zsSlj+1+9JSU6BvW2Wnmn/wPHwVWyHUPwoK5H18
         /xwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKDlqOZ6Wwn31TpDwiEGx7fpb9ygpHkE3KLl458V2a+DndFvuNm9+CLegyvtIp3l2ywYJpag==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDx5KyIrT0jL5Hu4/oNoQVrhZdzuomEuWJbiqD8QJkT651sIq5
	wkYWpJ5g+EFNNW3U3lDwEKb6Puezl5T4K24FuVm4BXX3aF47qV1uyt3O
X-Gm-Gg: ASbGncsGmHLxEcp36sq6b3+MQgexTWg8uf7tU+JiANNR2sv8RQ8NnQGzEVx1D1H9R36
	4Lp/u72cA2KcL/43rFN9M/HsDV1nRRWQNqBIkni/5HwpC6TNUbMk7zHHhZlRJRgwrkWm2dNeZL+
	FIpPph7R+42+E3+L0Vp7l3NVzo5HiBDmXqBIKxlExNDeuhJup+v0ZAT0G2kcdAt/4az9xmS8xto
	uZY1Rd+495++ealOQmoZHnXbYyzLifSS82wRCZzNUEU46WaXKqpjE8bjaaQ5y2yQsdlzEvg9347
	ZOYeLQNq9ixEY6aQHytBnYjQZh8cOyX0H5JicBOtKoYOxLizpcSUXB86UULcxQJx56gnZhR1xux
	eGg3SJTey6y2ETOtwEOxKfwIgKBQufy/mjvUM
X-Google-Smtp-Source: AGHT+IHpSaj2SVniGIDju9aHpbyUh48ii8/cQ5YSVvAGh2d+K7m0MNGtY13FQ+XBP5NLGndaXCuTRQ==
X-Received: by 2002:a05:6402:504b:b0:62f:cc4b:7b53 with SMTP id 4fb4d7f45d1cf-6349fa932c5mr14065525a12.37.1759146183418;
        Mon, 29 Sep 2025 04:43:03 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae3080sm7873345a12.34.2025.09.29.04.43.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Sep 2025 04:43:02 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:43:02 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: dev.jain@arm.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	baohua@kernel.org, bhe@redhat.com, chengming.zhou@linux.dev,
	chrisl@kernel.org, cl@gentwo.org, damon@lists.linux.dev,
	david@redhat.com, dvyukov@google.com, elver@google.com,
	glider@google.com, harry.yoo@oracle.com, jannh@google.com,
	jgg@ziepe.ca, jhubbard@nvidia.com, kasan-dev@googlegroups.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
	nphamcs@gmail.com, peterx@redhat.com, pfalcato@suse.de,
	rientjes@google.com, roman.gushchin@linux.dev, rppt@kernel.org,
	shikemeng@huaweicloud.com, sj@kernel.org, surenb@google.com,
	vbabka@suse.cz, xu.xin16@zte.com.cn
Subject: Re: [PATCH v2] mm: Fix some typos in mm module
Message-ID: <20250929114302.eshtdbqkjiuflsib@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <3c3f9032-18ac-4229-b010-b8b95a11d2a4@arm.com>
 <20250929002608.1633825-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929002608.1633825-1-jianyungao89@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Sep 29, 2025 at 08:26:08AM +0800, Jianyun Gao wrote:
>From: "jianyun.gao" <jianyungao89@gmail.com>
>
>Below are some typos in the code comments:
>
>  intevals ==> intervals
>  addesses ==> addresses
>  unavaliable ==> unavailable
>  facor ==> factor
>  droping ==> dropping
>  exlusive ==> exclusive
>  decription ==> description
>  confict ==> conflict
>  desriptions ==> descriptions
>  otherwize ==> otherwise
>  vlaue ==> value
>  cheching ==> checking
>  exisitng ==> existing
>  modifed ==> modified
>  differenciate ==> differentiate
>  refernece ==> reference
>  permissons ==> permissions
>  indepdenent ==> independent
>  spliting ==> splitting
>
>Just fix it.
>
>Signed-off-by: jianyun.gao <jianyungao89@gmail.com>

LGTM

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
