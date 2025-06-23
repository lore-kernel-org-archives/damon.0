Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2872624
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687695; cv=none; b=dYzR3L2l1ZRs0y7QRbkAMGUQUU4h+ihETz9VneUannIublC5QJ7O7+S2x5uKLIL0sBWOEEXIsQQkjGgUGkDoatsM4fl5PMx1jcqo8zqJTgxch30tOdlik+3dB+3EJyRQ2B7/uClLstt+X03K+EdPabMZfD40wbzTVSJrLCH44qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687695; c=relaxed/simple;
	bh=j2NwLLP+tVUQU3le2CHeY5WKItpY+MEWflBE5zdlwgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1vc29pz25QCGrRH7nVePV64je62XyAXxpiGC0FYVrOVFpG49VMwJh5nkXHWdSJbjwkxITeYMd1yy/wdilQhurKYKXhI6K9MgUzytNc1rSwkpxou9ZvaATkhyVn+Ex+AGUsjLImgj1XewgT2IRq28VFyKg8EqCHNcIhxy7ME46Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZwm5YMz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZwm5YMz"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e81826d5b72so3710822276.3
        for <damon@lists.linux.dev>; Mon, 23 Jun 2025 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750687692; x=1751292492; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EowSWZHgBam44vNn1dpUDGU5HPdMXeRQtrflhATFszk=;
        b=SZwm5YMzrrxQ0Eh/UCqWSGv8slHt9fKe2eTTG1N4uRdvWhMVu10uUuK/vIZnDB9cRc
         K2ozzRbFQO0Qu4/v97uqCQ9BLMZ6ngQLXmn/rNQG5YJ006227qTJJ4Wkt1CrYfUTDcJs
         FaUPEPPyl0KNmA8/vc1GIuq6nt4vioe3HowQ8sQyhxYBD8KeeBgx5DLtSqkQ0s4sTm4o
         RBTfYLa0ayRwum1TQhg8R7VmVuiKJHhhLVXT/w9/gmMmPT0ToPpl6aACWsRRGH9x1/7P
         /Dh8BNl5rhgLw4yDBEFF3uaZXCBLPu4pGnVn11y61z+1Pp8foKYUiYNsqSZH07TWrFcH
         MufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750687692; x=1751292492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EowSWZHgBam44vNn1dpUDGU5HPdMXeRQtrflhATFszk=;
        b=n0drfYyMxs7PbtIOonjCaVYDD62vCQD7ErooAwfQc+fb3X7fu3WmHZ2Fwb7ku/vC5s
         anPqT6EL6DgOTjHFSe/M60b/oB2m/z+dG1MGzrbb0B5hpIC+90+DGCr3QH/lgEira06o
         e51uhAU33CnlspObslrM4qVnVQ6DAh9DeVasNgwwwO3Olb9oU/iH8KugJwuqFjWpyLtw
         18JkY25hRBcXbHnSkeKEod8FeD7ak5/u7IZmYAZ1AWNXvgG9qeRgcpRfUM/cjaq/FAVG
         DPODm7rgJC5hurrCb9I18ijDHJK8wJtThiDpsSQyjx38mMQ3XdfPVnR8mxNfTmn+C6Pp
         Sg+A==
X-Forwarded-Encrypted: i=1; AJvYcCVAumHs9QctjuN8SNz5JAiFQAzGl9QWpJm8OLCU6bZ1ve0LeGpJrbX8cb/8zOQDzGegmC9SIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq+KKo3V+XdoCCc/+Nfwgft+67Vizz9dRmIrUcWCmbj06QIvh/
	0MvtudqT6KFVrq+oRjkckLk6X5UiHBHYX5oE4lpFnr7QTt+GBZt1v9C6
X-Gm-Gg: ASbGncu1uB/KaaQNKCfI2w+a1yOYADJtdYhlZLjPUEeCbvRfuMEfVa1cLVpQahG7shY
	FeLpoI+bcgHJ03y9tdab9JyUvmDL4amJ4d+F6Zr4BOd2rc8G5z3uIEOftqAk/d4G1SagUthMaIg
	qK93tnNZheHaIfCrC705e86vPKzUIBqlVhlwLJ4NkHy6b+HRBiG5pvVQvO5p+3h3umecNZOGqtv
	4a869UJMXdu416qczycdxfbJGw7hEjOILjj3JAMMXn+bWG+lJMEKPEfrXqQNGvjZiILq6xKZ9WV
	sEeNPjhlbJ4ehiBUIvVkuWChk4RG9rHjhZ9+1ShUqte4WXwfWTChtrGbXOjEHg==
X-Google-Smtp-Source: AGHT+IHYE3nYS125xTmonu6rlnXOXYSJSgL5k5E0ktAjTh63MUDrmHzRWNjGR5ZWVHUoeEPNQJRVuw==
X-Received: by 2002:a05:6902:72a:b0:e7d:cbd0:66a3 with SMTP id 3f1490d57ef6-e842bd078c9mr15228034276.35.1750687691448;
        Mon, 23 Jun 2025 07:08:11 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e85e70124e5sm341310276.11.2025.06.23.07.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:08:10 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Bijan Tabatabai <bijan311@gmail.com>,
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
Subject: Re: [RFC PATCH v2 2/2] mm/damon/paddr: Allow multiple migrate targets
Date: Mon, 23 Jun 2025 07:08:07 -0700
Message-ID: <20250623140808.2479244-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250621181127.36394-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Jun 2025 11:11:27 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sat, 21 Jun 2025 11:02:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> [...]
> > I'd hence suggest to implement and use a simple weights handling mechanism
> > here.  It could be roud-robin way, like weighted interleaving, or probabilistic
> > way, using damon_rand().
> > 
> > The round-robin way may be simpler in my opinion.  For example,

[...snip...]
 
> Actually, probabilistic way may be not that complicated.  Maybe we could to
> below here.

[...snip...]

> But damon_rand() might be more expensive than the roud-robin way, and arguably
> roud-robin way is what usrs who familiar with weighted interleaving may easily
> expect and even prefer?  I have no preferrence here.

Hi SJ,

If you have no preference here, I would like to add some thoughts : -)

I think that code complexity aside, round-robin may be the better choice for
a few reasons. Like you mentioned, I think it is what users might be used to,
if they are coming from weighted interleave code. Also, I think a round-robin
way will prevent worst-case scenarios where we get a long stretch of allocations
on the "wrong" node (but maybe this isn't a big deal, since it is so unlikely).

Finaly -- If we run workloads with mempolicy wet to weighted interleave
*and* with the weights already set, then pages will be allocated in a
round-robin fashion. I think it may be best to try and minimize migration costs
by trying to keep these weights in-sync. That is, if we have a 2:1 ratio,
we will have the following allocation:

node0 | oo oo oo oo oo oo oo ...
node1 |   o  o  o  o  o  o   ...

Using a probabilistic migration, it might change the pattern:

node0 |   oooo oo o ooo oo ...
node1 | oo    o  o o   o   ...

That is, the ratio might be preserved, but we may be doing unnecessary
migrations, since a probabilistic allocation isn't aware of any underlying
patterns. With a round-robin allocation, we have a 1/total_weight chance that
there will be no additional migrations, depending on where the round-robin
begins. I also want to note that weighted interleave auto-tuning is written
to minimize total_weight.

I'm wondering what you think about this. Perhaps there is a way to know where
the "beginning" of round-robin should begin, so that we try to keep the
allocation & migration pattern as in-sync as possible? I have a suspicion
that I am way over-thinking this, and none of this really has a tangible
impact on performance as well ;)

Thank you as always SJ, have a great day!!
Joshua

> Thanks,
> SJ
> 
> [...]
> 

Sent using hkml (https://github.com/sjp38/hackermail)
