Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711031FBCA1;
	Tue, 19 Aug 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618841; cv=none; b=aCjDU9g1b2PDrAGvtIh3fhp34UwwiYt0H3MZKSKl67crsQDb3xJWlJS8k0wpPz0+Da8MMv1Sz8TkHaxYjxn3oVNzUOuVneQytb4mUshoDFhGGjzViYCgIc12k4k9HdUrfDGwtuMaO3UyFWROlEUfmY3mblcEM7TN2K77bCSHyoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618841; c=relaxed/simple;
	bh=OJWuAh0cap69AqsWPSY5ghpUh2pe62oNjD5LFhuobQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXom9IN2WFIEYrTCH1dmezldWGfY/ceHp8MK7jmqU+CArGlMz+rJINnpXm6ZIceodym3YIOZCHyLyO44fj645xUFo/F4LrNRs97fXh2n1wWfl4c8OhzZZ4bf6JQJqN/f30a/uC3SX7LTifWJFW9D5enskGwVHuKZMBcnuvY/Nyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnzJjy6Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnzJjy6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D213AC4CEF1;
	Tue, 19 Aug 2025 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755618841;
	bh=OJWuAh0cap69AqsWPSY5ghpUh2pe62oNjD5LFhuobQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GnzJjy6QJWEZMcqby76tjDwiD6TbLu/1cmOXBgrzC0q684ceWOturm4HEC9W4q9O+
	 eL8cIXDtDmn55LNEpztTHGJyofjA22PgPnIMOhgvwtvDhGUSXNFTkyWN9b2b5Zf29H
	 IQr+05neVBTXHf/2wG2Ga2p+GjFf17ct5LpEjb0rta9ZWr6vbkn/lCRgaMyoNjEfub
	 949w5E2c4ifMZW4eAjTl9OoLiM6uOuCFkfKasWYpNl2ekDBb27ncF/xR4HkVjY26rg
	 WE4F+NGbJSc3VIRWtnAvn1LX/q40a9LD7hCUyQyKYL+doxSFseRnKD2ZFLWWaWXZJ2
	 qFgU2PtLocDqQ==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 03/16] mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
Date: Tue, 19 Aug 2025 08:53:58 -0700
Message-Id: <20250819155358.43711-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <6b9baf0c-fdc2-4f16-84f7-c4ada507f8f1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 19 Aug 2025 22:18:06 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Hi SJ,
> 
> 在 2025/8/19 14:26, SeongJae Park 写道:
> > Sorry for the above wrong link.  Plese use
> > https://lore.kernel.org/20250813170806.6251-1-sj@kernel.org instead.
> 
> Okay, I've merged the corresponding changes into the original patches. So now we have v2 versions
> for patches 3, 4, 5, and 6. I'll send out the patches later. That understanding is correct, right?

You're right :)


Thanks,
SJ

[...]
