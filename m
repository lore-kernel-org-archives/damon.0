Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05487366563;
	Wed, 11 Mar 2026 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238683; cv=none; b=ft3Kl2gzo/70DBvbJ5WVcTaxK0xk95zXworwcl+d/mXSOY9slpk/gj9gu4V3Fm890fz73Xbh0CKJ/EIAGiKJLLdXq/aabhEnAR9102InrRBP9EHYmDaXx/J4WlYBRgjwb7N8YLaSVCALs+D0CHErq/dVLLwfGJGwsvxJulPYP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238683; c=relaxed/simple;
	bh=thMAcRBBlSWiPQMxkurkltMdIsa+zjOuygZaQbtIy1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0O/YmOylgdUCLCfmROh2lq/9L3d3+y+Wd4EOa6XJrrmeKc2fPFAFGhXBkwuTFlEoNc4XdNHgzLofSlKfRZNf/oyXpcFjxiN73I8DBzOqoW47U6uCMNPnRDh/p980eZXm22sfHGNuHddOhSIkV917Z/rwgTCVcZmfbRKSR553cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJcweLKm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJcweLKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C25EC4CEF7;
	Wed, 11 Mar 2026 14:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773238682;
	bh=thMAcRBBlSWiPQMxkurkltMdIsa+zjOuygZaQbtIy1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJcweLKm9pp8NQp9VuqHN9g8KhPIAgSKYkkfrCK91Dse76Jy5LNRsMJfgggHjy0WJ
	 n+GgtNlQX1XEejWmDfSv4eh5QAFpi4qDOdZgkNn01QVPdoFDAc1K9wx5kBji1fRo1d
	 zDe10WErzLLJjshSAEyqrIcJVt57pk7/pHxMJk0JnJ+69U44Uw7Q1oSM6fPCb/dlUo
	 /Og7UF/JioKTYZ3ynhkxgylF0e631eLBsIeWimgQytJWU5CGOEcvuCLC2Mt1ETLSoF
	 kN9hZihzKQlvGBFKRqJiSs6zCWZPbBx8I2mTPKzPr5PhV3hrIqOQUci0OCL3YBhHrd
	 qV0POmeC7KNxA==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] mm/damon: Support for synchrounous huge pages collapse
Date: Wed, 11 Mar 2026 07:17:53 -0700
Message-ID: <20260311141753.96543-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <0c3068da-4dcb-4bc7-a762-2f529cb5abc2@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Mar 2026 16:11:12 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 3/11/2026 4:02 AM, SeongJae Park wrote:
> > On Tue, 10 Mar 2026 16:24:18 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> > 
> > Please add more descriptions of the change, including the motivation.
> > 
> > I assume the motivation is similar to MADV_COLLAPSE that aims to make
> > synchronous and therefore faster huge page collapsing impacts copared to
> > MADV_HUGEPAGE?  It would be nice to make it clear here.  Also, if my assumption
> > is not wrong, adding a test results showing the benefit of DAMOS_COLLAPSE over
> > DAMOS_HUGEPAGE here would be nice.
> 
> You are right. I will make it more clear in the cover letter for the next
> version.

Sounds good.  But please add a brief commit message in addition to the subject
here, too.  Some people complains blank commit message looks odd.


Thanks,
SJ

[...]
