Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314A4A11
	for <damon@lists.linux.dev>; Wed, 28 Sep 2022 17:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE1BC433C1;
	Wed, 28 Sep 2022 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664387984;
	bh=TLuv2+Flbr7K2dwKymjv0q3q32sR+IjJMe9UMLxknVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LhOOLkhWjeMVXx7ej4XGMqO8PW4RLHb/cN0FYg2F1A1heIudnavrwpBEZ+lT8Y9+Y
	 p8rojsx9gJfyfCJOCkYKpQWw+N7fUo0Z8m1Ge7s9YzvxbDyLcPdrRrdw/0wpNdMtzr
	 Kj7f3fziu12uwFx645sL2TMz/+3iSrrA/3EJrcy2f1gu6ygKN7Uye9E8EBydRvkwpK
	 DxsQl1HIOrB/dfp6OWIe22UldtK1ubjToWQe5GlcksHiXlxOfG2fMAGSFBxB3tO3IE
	 tPfGPtSzhTH79ApmeDL/OBG2N+WjlJozWTIAh7wJGh/H8wxdPcIgxxJWXsUvSUARz3
	 FCmrgVWc7KOJg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-damon-trial@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date: Wed, 28 Sep 2022 17:59:42 +0000
Message-Id: <20220928175942.168657-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> In short, I'd like to start an open, regular, and informal virtual bi-weekly
> meeting series for DAMON community.

The next instance of the series was scheduled to 2022-10-04 (Tue) 09:00 PDT
(https://meet.google.com/ndx-evoc-gbu), but I now reschedule it 30 minutes
after, due to a conflict.  So, the next instance will be:

    2022-10-04 (Tue) 09:30 PDT (https://meet.google.com/ndx-evoc-gbu)

I also updated the Google Doc for the agendas:
https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing

Looking forward to meet you!


Thanks,
SJ

[...]
