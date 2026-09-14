Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFDE46E002
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397039; cv=none; b=uX+uRsr8cDb/5CuXM/3ZW2j211dALhNIf6bz6kxGTmI3ahCJD7nlWrgPkOKPPw3cGNdm+RYxWnZQjT8SpSsalEPWems3O+dlT3INq1rWveg04tJdLMzwZLPu5cog1ZyjdY9KhhzHmDzKvIat5cqdUukQoAjkbVfLHP0HbvqhFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397039; c=relaxed/simple;
	bh=7+JBSq1lcxjIotZlZ8H7p6Vq1EEcX6XNFUx4HjDQ4oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdolHKs065hhyxA8eKQISsCAvD1hvAHcNK3TvHC69ALn4I1a/AsnpWhicPbswhlsBtkTST6A425Yf27KuOaO6cQ5pDL84bZxaOko+mWuAh+h/g3ropa8YhjpQ8BadMlZT7P/4wKYAAwhMQGyn9k9I+cLM70perrzcIZMYu3SoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E66vuPz7; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E66vuPz7"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b350c6920so1835316a91.1
        for <damon@lists.linux.dev>; Mon, 14 Sep 2026 07:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789397037; x=1790001837; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VbWdB1y5zAgVgUDU6C58oDPNhatCe/TzGoKd8VxEcJ0=;
        b=E66vuPz7vYCFaH3mi04kT9+D/8aGOkPC6HhxFdMltA27RMPiIHWkv+WyUvuHhIReYE
         gO5qjjwsXsG3dMFF2kJ3LzVL0lyDd44jylif/Hb068wLVjJ6jH7+K3PuecBY+jtVcFDK
         fG2wxdkdVNla+MTiUOFmnWYM0LivIeMI94emQTWWSf9Zt4N6x5BNiPN3Y66RqOVfwrcp
         /gY6wrDDTycfBW0wj+4BjOsl9dlpFtXJ8yxESECTUHkW52OPaYNBbYESOP5BhNK2tlMg
         o/sU/ORHToz6mdveOommSZ54klWv1D7Clw81IIGepzph4nPiwmYMHO+fL8ihB2fqH6ly
         dDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789397037; x=1790001837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VbWdB1y5zAgVgUDU6C58oDPNhatCe/TzGoKd8VxEcJ0=;
        b=AoD9pcyUwsy+FGJrKKK7eHk4wg40hdiNK8m8XO3xD7dmvvo1MWIor+XydKfXMK7eRn
         EkKUdYUj+eL2TIRKjVmN8JlepUKYfFo8UnRziV9H2v76NHdfrcT5+VJ/3ax/3EKHPT5K
         O84vCR5k8q3X4006hktQqxwd0y4KInfVkXVGxh17wb6T7hPdOXukMHKcpa1H9DNC9ybA
         1xSs9jrAQ5nKssPNJdLaijv4Ys9zU0rZkae12I4SLXWe/H2zjOsZBnXm65lEzsOL7zQy
         fdt0usbgpBHzhEKqimCYBS4oo8LZXoQkWFimoQ1E1t70cTjltvqb+v3QusY2BnR7vfKH
         wFuQ==
X-Forwarded-Encrypted: i=1; AKwUvBznDbz/SG0tEQdgeuR5yWF0QeOkzOwqfZctiqTlHc8oR+BY0c1PQ9M4BbDvxuMvYYNQV/OQEA==@lists.linux.dev
X-Gm-Message-State: AFuF++kW5tgtGBQEBfyuyIOiOHpzPhM00p+olJx6s2NuZkuDYg4lJ1lH
	ybr2yqQQHIHYesBJweyMvVakHw0Z2sWd+SqHj3C8T4hn2OEfDW5H+6DmqmQEuL6qK0M=
X-Gm-Gg: AYBFou2vmd/hUz3nxz/HN8AXDBDjWqZvFaKi8KX8cBcjXBtTgLYtv5J7LEdUty7WCpR
	08JGnN5M5T59lXuloGjwjfB6XrvSKWCw5ZZA1SYoGGs5NsIbkAh+4IC+1GOemwts2kRubGKbbYu
	T6JvKPNQppjXTtxfg32xVDAY8bI2WmgyeRiPiQuVyaUeztxpPq66fs6dZ1jSkAgMgsIhP4seTwC
	g+ViBF2ynDRbNoNZ2RUgth9uxGM/xf+2SBANc2ve1RTIlkmxPznsf9y9sbM5Ka865x0FpWDQvCS
	eawH8eMeqo9HPPLKpC8KEs1TF0yH2pvNhemwd0ikJ7jTM8bruhjp4YTqucjtAG/t4TJ1p+dsSHF
	PKUJipRdIL7D/7QpK9mAHCUVGRbQROjE60tiUFA0LxF1d734YvB1Tf6ZMat/Ym1ff2TON/NUnd+
	ZBf3vlaC9rKMogKyOo9nLNTeAsJ8VgyY7Exgjl/v3F/Z7llw35jy/pEiMScJgn9szQc66yqUqja
	pk=
X-Received: by 2002:a17:90b:4a82:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-39dec05f681mr5602152a91.15.1789397037224;
        Mon, 14 Sep 2026 07:43:57 -0700 (PDT)
Received: from celestia ([2402:1980:8858:8cc0:7bda:d54a:257:22ec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994d8af1sm22675307a91.11.2026.09.14.07.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:43:56 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: add short circuit for esz<min_region_sz in damos_adjust_quota()
Date: Mon, 14 Sep 2026 22:42:34 +0800
Message-ID: <20260914144409.4592-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913162046.99109-1-sj@kernel.org>
References: <20260913162046.99109-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 09:20:45 -0700 SJ Park <sj@kernel.org> wrote:

> Hi Liew,
> 
> 
> From the next time, please complete discussions on the previous version before
> posting a new version.  For example, in this case, you could replied to my last
> reply to the previous version of this patch saying you will accept my suggested
> changes and wait a reasonable time to decide there is no other opinions.

Thank you for your guidance.  From the next time, I will reply and say
if I will accept your suggestions.

> 
> I think the subject is not very clear.  How about something like, "skip quota
> score setup when quota is full"?

Sure, it is shorter and more understandable.

> 
> On Sun, 13 Sep 2026 19:01:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > After damos_set_effective_quota(), the effective size quota may be lower
> > than min_region_sz (e.g., when the temporal quota goal is [over-]achieved).
> 
> This sounds unnecessarily specific and doesn't cover all the case.  What about
> 
> "In damos_adjust_quota(), the quota could already be full."

Agree, that makes sense.  Since users who is using temporal quota
auto-tuning should know what happens when goal is achieved.

> 
> > 
> > In this situation, damos_adjust_quota() will still calculates
> > quota->min_score.  However, this min_score will not be used in this
> > window, because in damon_do_apply_schemes(), damos_quota_is_full() will
> > always returns true, preventing the scheme from being applied to any
> > region.
> > 
> > Therefore, add a short circuit for 'esz < min_region_sz' schemes to
> > early return from damos_adjust_quota() before calculating min_score.
> > 
> > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> 
> Assuming you agree to above suggestions,

Yes, I agree those all suggestions.

> 
> Reviewed-by: SJ Park <sj@kernel.org>
> 
> With the above assumption, I modified this patch with the suggestions and
> applied to damon/next [1] tree.  I will repost it for mm.git merge after a
> week.  So, if you are ok with the plan, no action from your side is needed.
> 
> Please let me know if you have different opinions.
> 
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees

Best regards,
Rui Yan
