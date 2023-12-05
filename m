Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C46D264
	for <damon@lists.linux.dev>; Tue,  5 Dec 2023 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QM3JaUd6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ncz6t9/1ak5tQzeNdq4sicxqCjunw4/Fask4L2znKlk=; b=QM3JaUd6O6kjwVIotWLkMsWcxw
	FFEFIyTuo20WeeS3rQnMzCF5h5fdXw9F8hUIsor4c9xc0N3vv6XuUql4TGd5zAU7DeNSunKZTUTU1
	Fj79EOc9Kbkma5HiXEq/Gq99kU0kl5OUzVHOcJ+JETE8Az/fbNGD3MdK9b+P7GMFQDfMISGDcbdw5
	75pQZ50ioG1Xcx228O5yXnqapN4gUJhQtz6LEPQmk0UR1PYqG3CIsox+F2Ra3seecq3Gml6BZbSQa
	YZqTv9VZrMp/f4mPzxJf5+4i2o6K0HuMH1xDxdDNkxEvipwM5Qq263/xrEmUNXKh8kRNfPOeVbE2o
	0iODzysw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rANjj-006Hnu-0y;
	Tue, 05 Dec 2023 05:12:47 +0000
Date: Mon, 4 Dec 2023 21:12:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/damon: export DAMON symbols and add sample
 loadable modules
Message-ID: <ZW6xTyyl0qvcqi3O@infradead.org>
References: <20231205022858.1540-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205022858.1540-1-sj@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 05, 2023 at 02:28:55AM +0000, SeongJae Park wrote:
> DAMON cannot be used from loadable modules since it is not exporting its
> symbols.

And that is a good thing.  We should absolutely not allow random modules
probing MM internals.   What you posted here is basically just adding
hooks without even real in-kernel users.

