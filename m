Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E12D73B6;
	Sun,  5 Apr 2026 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775418064; cv=none; b=bwaH3mByIC1b9aEH94zb+eJtN9zeH07n/6phYtIoPZY/VK51/N0K7C9V/Ks8/yuyl5vOQobG6u1kYEDtBvdMXnCvNjCISHS1iF0ad+bghLB07XcKhSIfOeOCFBatgK00i3zta8rLE0aHXNbKRMekvPoVvYcv9oTLArb8kj+rFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775418064; c=relaxed/simple;
	bh=DGaCv3yuy1SMBsA/JWL/C7jzP/beOyE7rUQqr+dAcS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsmWlXyOZy9kX/62Ta/rnTGw/CsI0DYCmje8ZssWWNiNW4y1f029q/QTa2EiyrGKVTy8vxcCgiyCyf3IHrbIZl+6OfGQhkYkiKC8qYmEsupDzb9iesMNONcZChbGV2PPncR5BTQPerYzWf8CSa8MB5NygsgK+EkaPMpvscpChzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrLDzWmF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrLDzWmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002D5C116C6;
	Sun,  5 Apr 2026 19:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775418064;
	bh=DGaCv3yuy1SMBsA/JWL/C7jzP/beOyE7rUQqr+dAcS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrLDzWmFqW41w3HexDrBup9TywlrR389YD3EJvobttbQ1v0kL17sxLfTw9N8VXVEz
	 CNw6FaphRVyf87J5G8uaV3SR3jeGB+sB1A/VFTcOElrL4BZdAUVa1Gr9gpqQTBwW/r
	 s2zv76GQRGJ6Mn09f9dgQHzYlKpkXmUf/s93WdBe1tO2eXATXBRfuqd+8QrcGH3zH5
	 9sbZJGjZbNVy+a6A59I5W/ZFpFvu8RsQmA0e6uhVCdO+h49c3oVb1lWbda+UU2ormN
	 Yz4396S0dCyuEwE+y6ow47mug94l1vsdUr+CtiHTlsROOtfCIBh78xzQoNONnTpD8J
	 tqHR8olvoAUbg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v2 7/9] selftets/damon/_damon_sysfs: support failed region quota charge ratio
Date: Sun,  5 Apr 2026 12:40:56 -0700
Message-ID: <20260405194057.110507-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260405151232.102690-8-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko found a typo and a false positive issue.  I will fix the typo
in the next revision of this patch.

Forwarding full sashiko review in a reply format with my 
inline comments below, for sharing details of my view and
doing followup discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260405151232.102690-8-sj@kernel.org
> # start of sashiko.dev inline review
> commit 47cf42ea4e5f609d65881ae5f8f8491bb884a8bf
> Author: SeongJae Park <sj@kernel.org>
> 
> selftets/damon/_damon_sysfs: support failed region quota charge ratio
> 
> This commit extends the _damon_sysfs.py selftests utility to support the
> new DAMOS action failed regions quota charge ratio feature.
> 
> > selftets/damon/_damon_sysfs: support failed region quota charge ratio
> 
> This isn't a bug, but there is a typo (selftets) in the subject line.

Good eye, I will fix it in the next revision.

> 
> > diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
> > index 2b4df655d9fd0..0f13512fa5e6d 100644
> > --- a/tools/testing/selftests/damon/_damon_sysfs.py
> > +++ b/tools/testing/selftests/damon/_damon_sysfs.py
> [ ... ]
> > @@ -132,14 +132,17 @@ class DamosQuota:
> [ ... ]
> >      def __init__(self, sz=0, ms=0, goals=None, goal_tuner='consist',
> > -                 reset_interval_ms=0, weight_sz_permil=0,
> > -                 weight_nr_accesses_permil=0, weight_age_permil=0):
> > +                 reset_interval_ms=0, fail_charge_num=0, fail_charge_denom=0,
> > +                 weight_sz_permil=0, weight_nr_accesses_permil=0,
> > +                 weight_age_permil=0):
> 
> Will inserting fail_charge_num and fail_charge_denom before the weight
> parameters cause issues for any existing code that passes arguments
> positionally?
> 
> Any scripts or in-flight patches instantiating DamosQuota using positional
> arguments for the weight parameters might silently assign those values to
> the new charge ratio variables instead. 
> 
> Could these optional parameters be added to the end of the argument list to
> avoid altering the existing positional signature?

No.  There is no existing code that calls DAmosQuota() with positional
arguments.  Hence no change to this patch is needed.

> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260405151232.102690-8-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260405151232.102690-8-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
