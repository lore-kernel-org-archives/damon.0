Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D079C2A1AA
	for <damon@lists.linux.dev>; Thu,  5 Sep 2024 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553859; cv=none; b=RngbLQ5EWAHK5krt5ar6VmuN2uglQIP9z/efg4smGZ+8YkaZ7mK5z6i4ApM+QwWdJHVmc8OpsCns1arKzTLW14wgCsMyuVq5qIAsJXgjOK1AaKVYJZovxCNlNxIJD4a7P5zKNw7Q4HsDEtUaC0yJDg8E1xc/tyLiDksX6V1pX4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553859; c=relaxed/simple;
	bh=KreO2soIcNNVhRPjlwIbhb5WlCBh1UoQIs1tNUo6UPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kasiJ4Fo4BbpIdTBtgG84RmcxleIn5iF3hEpabhH/mrvUPK1K4TRL4Hed2SN2rbo7g2Hh0eNMBqLcqGgP8jL3NSEOpBeGmzpVy8hENKtYwLcCFJX3EwKg/aO+O5/PRulOPPhZs8Y71VjZT+WqThFOLRDS1R/yE5mE5HGljx1ZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJwsa/oJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJwsa/oJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A89C4CEC3;
	Thu,  5 Sep 2024 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553859;
	bh=KreO2soIcNNVhRPjlwIbhb5WlCBh1UoQIs1tNUo6UPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJwsa/oJSZcMLPjSDhBPrIirnDSwzWgj3M3pcYg3I8h8ZIJUL25YayOVvzb2UdeAX
	 XQnauPg2oZuAtwrPxdN9Sud3+K5Ncj4+mtAqeG7KKJyJUkvQ++yNlmLzJcujxUTTt0
	 y4yNmclTN8eWUZ9J2kd/oAYsFOBAG62LDSMqPq/Zb23NKOAmutre+LRxYnCYsUGGU+
	 5q5nZB/zqEB/zNgYL2FV8zjp5RKhA0wsr1MStQzkmkASu75XpRrHJbRYq6+qRhLV0A
	 GTjKBkKqqsVCQSeCn/e5AwGIkTcHttGSXdslLzcj8JF40iOuczLzAZn8O4kSOtuFmL
	 S8TnjR6o0BiNA==
From: SeongJae Park <sj@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Problems running DAMON kunit tests with spinlock debugging enabled
Date: Thu,  5 Sep 2024 09:30:56 -0700
Message-Id: <20240905163056.74132-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <c62934de-001d-4f41-bc00-17244cd04d89@roeck-us.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 4 Sep 2024 12:06:29 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> On 9/4/24 10:53, SeongJae Park wrote:
> > On Tue, 3 Sep 2024 19:46:44 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> >> On 9/3/24 19:24, Guenter Roeck wrote:
> >>> On 9/3/24 18:00, SeongJae Park wrote:
> >>>> Hi Guenter,
> >>>>
> >>>> On Tue, 3 Sep 2024 12:23:50 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
[...]
> >>> Some more problems. I tried your patch on various architectures.
> >>> Unfortunately, that didn't turn out well. See below for some of the failures.
> > 
> > Nice finding, thank you for reporting this!  Just to be clear, seems this is
> > independent from the originally reported issue or the fix for it.  Please let
> > me know if not.
> > 
> 
> It is a different problem.

Thank you for confirming :)

[...]
> > I think doing the skip if the resulting
> > aggr_interval is zero would make more sense.  Having more comments would also
> > be nice.
> > 
> 
> Sure; the above was not intended to be a final (or even acceptable) fix,
> just a workaround to let me run tests with damon kunit tests enabled
> on 32-bit systems.

Thank you for kindly agreeing and clarifying.  I just posted the fix:
https://lore.kernel.org/20240905162423.74053-1-sj@kernel.org

Hopefully the patch explains more details and my opinions.


Thanks,
SJ

> 
> Thanks,
> Guenter
