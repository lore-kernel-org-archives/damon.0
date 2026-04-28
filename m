Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF419CD03;
	Tue, 28 Apr 2026 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337104; cv=none; b=DYzTUPn6AiG7hLbgHdqg4Owt8kOWvGEx5DC4M/iNnS/I7I4V4ygr7zs6P/2RzYSmlCuaIbyp8AoB9pha/spAeQccZ/p7f/ofrAxcJZs0N4g8ajDLvPGZs3gJOQCaQrAeZ+9UuJlXa21W7BdsH7uuLIGdQTJ0BK7EqfbKRZ1VhUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337104; c=relaxed/simple;
	bh=w+KfGykqmSbSQkq+ww/Klt27t8J2MFRZ7n8ybXamOSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZTbneK/9lu9PBWVLPaTbiuocK+iQj/Bh8v6aUVgEAa+vuC+0kF/kGhLn0vcRWA9EzDcuCaMGrHONuWiFXTCOMc6RJau7qW6A/tabn6zXvYs8kcHHOHtG2adkOGktioID+khYmUqE7GLn8kPaf93iuwq03TxeYkuJjBKb44GOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbuZCbob; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbuZCbob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CD6C19425;
	Tue, 28 Apr 2026 00:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337103;
	bh=w+KfGykqmSbSQkq+ww/Klt27t8J2MFRZ7n8ybXamOSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbuZCbobFcgQmoszya8nZwxi/D0MTMxubAn3oSkBpHjOFYonPA0Slj+Pk9KwquUhq
	 wjaiSnVxBymgzpLgYL2oKD9OiejRMWwEXCZjmO3bDT7g0zG6/oBt8tCyq1NWm6sF+1
	 11YAf8mC2/pqtwLk/sGPPbrzM4WKmT5nYN1CmUco+nQ9JAvlyVjS/pFjOTWbFRMt2T
	 utjRoXzSrjSDLR3uH4KZuZVa9BLHCRIiDwtnRoz72eY/blwe2vuF9N0MuU84lXpQP6
	 nsy4vcH+gJgTjA2oo3C4t1leZm0aFuf05TdOpxtlKRH4QxovMA5XB2ArvNo36xhK6s
	 XpD3eQD3KLjvg==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 13/19] mm/damon/sysfs: implement filter dir files
Date: Mon, 27 Apr 2026 17:44:54 -0700
Message-ID: <20260428004454.113463-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <666090aa-a679-4ce4-b66a-a5bba8284268@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 27 Apr 2026 16:24:10 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 4/26/2026 11:52 PM, SeongJae Park wrote:
> > Implement sysfs files under the data probe filter directory for letting
> > users to configure each filter.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
[...]
> > +static ssize_t type_show(struct kobject *kobj,
> > +		struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct damon_sysfs_filter *filter = container_of(kobj,
> > +			struct damon_sysfs_filter, kobj);
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(damon_sysfs_filter_type_names); i++) {
> > +		const struct damon_sysfs_filter_type_name *type_name;
> Can we move this declaration to the top of the function?

Unfortunately other parts of sysfs.c and sysfs-schemes.c including
operations_show/store(), type_show/sotre(), metric_show/store()  are also using
this pattern.  I'd like to keep the style consistency, if I'm not missing
something and you don't mind.


Thanks,
SJ

[...]
